project(protocol)

add_library(${PROJECT_NAME}
    src/eraftkv.pb.cc
    src/eraftkv.grpc.pb.cc
)

target_link_libraries(${PROJECT_NAME}
    ${Protobuf_LIBRARY}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC ${PROJECT_SOURCE_DIR}/include
)
