// HTMX / C (same-thing)
// C webserver with clearsilver templates
#include <arpa/inet.h>
#include <ctype.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <pthread.h>
#include <regex.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "./details.h"
#include "./meta.h"

#define PORT 3000
#define BUFF 1024 * 1024 /*2^20*/

bool RUNNING = true;

void skill(int reason, const char* msg) {
  printf("Killing server...\n");
  if (msg != NULL) {
    printf("%s\n", msg);
  }

  RUNNING = false;
  exit(reason);
}

void interkill(int sig) { skill(EXIT_SUCCESS, NULL); }

void build_http_response(const char* file_name, const char* file_ext,
                         char* response, size_t* response_len) {
  printf("Request: %s\n", file_name);
  if (strlen(file_name) == 0) {
    file_name = "index.html";
  }

  char* header = (char*)malloc(BUFF * sizeof(char));
  make_header(header, 200, "OK", get_mime_type(file_ext));

  // hard coding /details
  if (strcmp(file_name, "details") == 0) {
    char* details_html = (char*)details();
    snprintf(response, BUFF, "%s%s", header, details_html);
    *response_len = strlen(response);
    free(header);
    free(details_html);
    return;
  }

  // if file not exist, response is 404 Not Found
  int file_fd = open(file_name, O_RDONLY);
  if (file_fd == -1) {
    make_header(header, 404, "Not Found", "text/html");
    snprintf(response, BUFF, "%s404 Not Found", header);
    *response_len = strlen(response);
    return;
  }

  // get file size for Content-Length
  struct stat file_stat;
  fstat(file_fd, &file_stat);
  off_t file_size = file_stat.st_size;

  // copy header to response buffer
  *response_len = 0;
  memcpy(response, header, strlen(header));
  *response_len += strlen(header);

  // copy file to response buffer
  ssize_t bytes_read;
  while ((bytes_read = read(file_fd, response + *response_len,
                            BUFF - *response_len)) > 0) {
    *response_len += bytes_read;
  }
  free(header);
  close(file_fd);
}

void* handle_client(void* arg) {
  int client_fd = *((int*)arg);
  char* buffer = (char*)malloc(BUFF * sizeof(char));

  ssize_t bytes_received = recv(client_fd, buffer, BUFF, 0);
  if (bytes_received > 0) {
    regex_t regex;
    regcomp(&regex, "^GET /([^ ]*) HTTP/1", REG_EXTENDED);
    regmatch_t matches[2];

    // DECODE -> GET FILEEXT -> BUILD RESPONSE -> SEND RESPONSE
    if (regexec(&regex, buffer, 2, matches, 0) == 0) {
      buffer[matches[1].rm_eo] = '\0';
      const char* url_encoded_file_name = buffer + matches[1].rm_so;
      char* file_name = url_decode(url_encoded_file_name);

      char file_ext[32];
      strcpy(file_ext, get_file_extension(file_name));

      char* response = (char*)malloc(BUFF * 2 * sizeof(char));
      size_t response_len;
      build_http_response(file_name, file_ext, response, &response_len);

      send(client_fd, response, response_len, 0);
      free(response);
      free(file_name);
    }
    regfree(&regex);
  }
  close(client_fd);
  free(arg);
  free(buffer);
  return NULL;
}

int main(int argc, char* argv[]) {
  signal(SIGINT, interkill);
  signal(SIGTERM, interkill);

  int server_fd;
  struct sockaddr_in server_addr;

  if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
    skill(EXIT_FAILURE, "Failed to create socket");
  }

  server_addr.sin_family = AF_INET;
  server_addr.sin_addr.s_addr = INADDR_ANY;
  server_addr.sin_port = htons(PORT);

  if (bind(server_fd, (struct sockaddr*)&server_addr, sizeof(server_addr)) <
      0) {
    skill(EXIT_FAILURE, "Failed to bind socket");
  }
  if (listen(server_fd, 10) < 0) {
    skill(EXIT_FAILURE, "Failed to listen");
  }

  printf("Server listening on port %d\n", PORT);
  while (RUNNING) {
    struct sockaddr_in client_addr;
    socklen_t client_addr_len = sizeof(client_addr);
    int* client_fd = malloc(sizeof(int));

    if ((*client_fd = accept(server_fd, (struct sockaddr*)&client_addr,
                             &client_addr_len)) < 0) {
      perror("accept failed");
      continue;
    }

    pthread_t thread_id;
    pthread_create(&thread_id, NULL, handle_client, (void*)client_fd);
    pthread_detach(thread_id);
  }

  close(server_fd);
  return 0;
}