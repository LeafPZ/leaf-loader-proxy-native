cmake_minimum_required(VERSION 4.1)
project(leaf_loader_proxy_native LANGUAGES C VERSION 1.0.0)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

add_library(leaf_loader_proxy_native SHARED src/lib.c)

if (MSVC)
    target_compile_options(${CMAKE_PROJECT_NAME} PRIVATE
            # disable the buffered security checks
            /GS-
            # optimisations
            $<$<CONFIG:Release,MinSizeRel>:/O1>
            $<$<CONFIG:Release,MinSizeRel>:/GL>
            $<$<CONFIG:Release,MinSizeRel>:/GR->
            $<$<CONFIG:Release,MinSizeRel>:/EHs->
            $<$<CONFIG:Release,MinSizeRel>:/EHa->
    )
    target_link_options(${CMAKE_PROJECT_NAME} PRIVATE
            # disable CRT
            /NODEFAULTLIB
            /ENTRY:DllMain
            # link time code gen + optimisations
            $<$<CONFIG:Release,MinSizeRel>:/LTCG>
            $<$<CONFIG:Release,MinSizeRel>:/OPT:REF>
            $<$<CONFIG:Release,MinSizeRel>:/OPT:ICF>
    )
endif()

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        MSVC_RUNTIME_LIBRARY "MultiThreadedDLL"
        INTERPROCEDURAL_OPTIMIZATION TRUE
        OUTPUT_NAME "leaf"
)
