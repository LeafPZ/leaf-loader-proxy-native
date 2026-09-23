#define WIN32_LEAN_AND_MEAN
#include <windows.h>

static BOOL WINAPI DllMain(HINSTANCE inst, DWORD reason, LPVOID reserved) {
    return TRUE;
}

static LPCWSTR toWideString(const char* s) {
    const int sz = MultiByteToWideChar(CP_UTF8, 0, s, -1, NULL, 0);
    if (sz <= 0 || sz >= MAX_PATH) {
        return NULL;
    }

    wchar_t buf[MAX_PATH];
    MultiByteToWideChar(CP_UTF8, 0, s, -1, buf, sz);
    return buf;
}

static void log(const char* s) {
    WriteConsoleA(GetStdHandle(STD_OUTPUT_HANDLE), s, lstrlen(s), NULL, NULL);
}

__declspec(dllexport) int Agent_OnLoad(void **vm, const char *options, void *reserved) {
    BOOL res = FALSE;
    if (options != NULL && options[0] != '\0') {
        const LPCWSTR wide = toWideString(options);
        if (wide != NULL) {
            res = SetDllDirectoryW(wide);
        } else {
            res = SetDllDirectoryW(L".\\jre64\\bin");
        }
    } else {
        res = SetDllDirectoryW(L".\\jre64\\bin");
    }

    if (res == FALSE) {
        log("Agent failed to add dll directory\n");
        MessageBoxW(NULL, L"Agent failed to add dll directory", L"Leaf Native", 0);
        return -1; // JNI_ERR
    }

    log("Agent initialisation successful\n");
    return 0; // JNI_OK
}
