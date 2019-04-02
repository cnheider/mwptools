#include "gskf.h"

GSettingsBackend* get_key_file_backend(const char* fname, const char* group)
{
    GSettingsBackend* settings_backend;
    return g_keyfile_settings_backend_new (fname, KPATH, group);
}
