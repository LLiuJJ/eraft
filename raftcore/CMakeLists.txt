project(eraftcore)

add_library(${PROJECT_NAME}
    src/raft_server.cc
    src/eraftkv.pb.cc
    src/util.cc
)

target_link_libraries(${PROJECT_NAME}
    ${Protobuf_LIBRARY}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC ${PROJECT_SOURCE_DIR}/include
)