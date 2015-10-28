set(EXAMPLES
  console
  delayedloop
  stream
  trivial
)

include_directories(
  ${APR_INCLUDE_DIR}
  ${APRutil_INCLUDE_DIR}
  ${PROJECT_BINARY_DIR}
  $${PROJECT_SOURCE_DIR}/src/main/include
)

foreach(example ${EXAMPLES})
  add_executable(${example} ${example}.cpp)
  target_link_libraries(${example} log4cxx ${APR_LIBRARY} ${APRutil_LIBRARY})
endforeach()
