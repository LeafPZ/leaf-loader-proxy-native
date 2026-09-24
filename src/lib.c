#define WIN32_LEAN_AND_MEAN
#include <windows.h>

static BOOL WINAPI DllMain(HINSTANCE inst, DWORD reason, LPVOID reserved) {
    return TRUE;
}

static void info(const char* s) {
    WriteConsoleA(GetStdHandle(STD_OUTPUT_HANDLE), s, lstrlen(s), NULL, NULL);
}

__declspec(dllexport) int Agent_OnLoad(void **vm, const char *options, void *reserved) {
    BOOL res = FALSE;
    if (options != NULL && options[0] != '\0') {
        if (options != NULL) {
            res = SetDllDirectoryA(options);
        } else {
            res = SetDllDirectoryA(".\\jre64\\bin");
        }
    } else {
        res = SetDllDirectoryA(".\\jre64\\bin");
    }

    if (res == FALSE) {
        info("Agent failed to add dll directory\n");
        MessageBoxA(NULL, "Agent failed to add dll directory", "Leaf Native", 0);
        return -1; // JNI_ERR
    }

    info("Agent initialisation successful\n");
    return 0; // JNI_OK
}
