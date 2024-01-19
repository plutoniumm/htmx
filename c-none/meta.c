#include "./meta.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFF 1024 * 1024 /*2^20*/

const char* make_header(char* header, int status_code,
                        const char* status_message, const char* mime_type) {
  snprintf(header, BUFF,
           "HTTP/1.1 %d %s\r\n"
           "Content-Type: %s\r\n"
           "\r\n",
           status_code, status_message, mime_type);
  return header;
}

const char* get_file_extension(const char* file_name) {
  const char* dot = strrchr(file_name, '.');
  if (!dot || dot == file_name) {
    return "";
  }
  return dot + 1;
}

const char* get_mime_type(const char* file_ext) {
  /* */ if (strcasecmp(file_ext, "html") == 0 ||
            strcasecmp(file_ext, "htm") == 0) {
    return "text/html";
  } else if (strcasecmp(file_ext, "js") == 0) {
    return "application/javascript";
  } else if (strcasecmp(file_ext, "css") == 0) {
    return "text/css";
  } else if (strcasecmp(file_ext, "json") == 0) {
    return "application/json";
  } else if (strcasecmp(file_ext, "svg") == 0) {
    return "image/svg+xml";
  } else if (strcasecmp(file_ext, "xml") == 0) {
    return "application/xml";
  } else if (strcasecmp(file_ext, "txt") == 0) {
    return "text/plain";
  } else if (strcasecmp(file_ext, "jpg") == 0 ||
             strcasecmp(file_ext, "jpeg") == 0) {
    return "image/jpeg";
  } else if (strcasecmp(file_ext, "png") == 0) {
    return "image/png";
  } else if (strcasecmp(file_ext, "pdf") == 0) {
    return "application/pdf";
  } else {
    return "application/octet-stream";
  }
}

char* url_decode(const char* src) {
  size_t src_len = strlen(src);
  char* decoded = malloc(src_len + 1);
  size_t decoded_len = 0;

  // decode %2x to hex
  for (size_t i = 0; i < src_len; i++) {
    if (src[i] == '%' && i + 2 < src_len) {
      int hex_val;
      sscanf(src + i + 1, "%2x", &hex_val);
      decoded[decoded_len++] = hex_val;
      i += 2;
    } else {
      decoded[decoded_len++] = src[i];
    }
  }

  decoded[decoded_len] = '\0';
  return decoded;
}