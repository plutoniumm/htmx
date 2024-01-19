#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFF 1024 * 1024 /*2^20*/

struct Website {
  const char* name;
  const char* url;
  const char* logo;
};

struct Website data[] = {
    {"Bun", "https://bun.sh/docs", "https://bun.sh/logo_avatar.svg"},
    {"HTMX", "https://htmx.org/docs", "https://htmx.org/img/htmx_logo.2.png"},
    {"Hono", "https://hono.dev/", "https://hono.dev/images/logo.png"},
};

const char* c(const char* a,
              const char* b) {  // sometimes a man just needs to copy
  char* result = (char*)malloc(BUFF * sizeof(char));
  snprintf(result, BUFF, "%s%s", a, b);
  return result;
}

const char* tag(const char* res, const char* tag, const char* content,
                const char* attr) {
  if (attr == NULL) {
    attr = "";
  }
  snprintf((char*)res + strlen(res), BUFF, "<%s %s>%s</%s>", tag, attr, content,
           tag);
  return res;
}

const char* vtag(const char* result, const char* tag, const char* attr) {
  if (attr == NULL) {
    attr = "";
  };
  snprintf((char*)result + strlen(result), BUFF, "<%s %s />", tag, attr);
  return result;
}

// return ul[li[a[url, name] img[logo]]] from websites
const char* details() {
  char* result = (char*)malloc(BUFF * sizeof(char));
  tag(result, "h3", "Welcome to HTMX!", "style=\"text-align:center;\"");
  tag(result, "p",
      "You're using these tools, check their docs to learn more:", NULL);

  char* list = (char*)malloc(BUFF * sizeof(char));
  char* inner = (char*)malloc(BUFF * sizeof(char));
  for (int i = 0; i < sizeof(data) / sizeof(data[0]); i++) {
    vtag(inner, "img", c("src=", data[i].logo));
    vtag(inner, "a", c("href=", data[i].url));

    tag(list, "li", strcat(inner, data[i].name), NULL);
    memset(inner, 0, strlen(inner));
  }
  tag(result, "ul", list, NULL);

  return result;
}
