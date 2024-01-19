const char* make_header(char* header, int status_code,
                        const char* status_message, const char* mime_type);
const char* get_file_extension(const char* file_name);

const char* get_mime_type(const char* file_ext);

char* url_decode(const char* src);