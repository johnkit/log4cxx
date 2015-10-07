include_directories(
  ${APR_INCLUDE_DIR}
  ${APRutil_INCLUDE_DIR}
  ${PROJECT_BINARY_DIR}
  $${PROJECT_SOURCE_DIR}/src/main/include
)

set(UTIL_SOURCES
  util/absolutedateandtimefilter.cpp
  util/absolutedateandtimefilter.h
  util/absolutetimefilter.cpp
  util/absolutetimefilter.h
  util/binarycompare.cpp
  util/binarycompare.h
  util/compare.cpp
  util/compare.h
  util/controlfilter.cpp
  util/controlfilter.h
  util/filenamefilter.cpp
  util/filenamefilter.h
  util/filter.h
  util/iso8601filter.cpp
  util/iso8601filter.h
  util/linenumberfilter.cpp
  util/linenumberfilter.h
  util/relativetimefilter.cpp
  util/relativetimefilter.h
  util/serializationtesthelper.cpp
  util/serializationtesthelper.h
  util/threadfilter.cpp
  util/threadfilter.h
  util/transformer.cpp
  util/transformer.h
  util/utilfilter.cpp
  util/xmlfilenamefilter.cpp
  util/xmlfilenamefilter.h
  util/xmllineattributefilter.cpp
  util/xmllineattributefilter.h
  util/xmlthreadfilter.cpp
  util/xmlthreadfilter.h
  util/xmltimestampfilter.cpp
  util/xmltimestampfilter.h
)

add_executable(testsuite
  abts.cpp
  logunit.cpp
  ${UTIL_SOURCES}
  appenderskeletontestcase.cpp
  consoleappendertestcase.cpp
  writerappendertestcase.cpp
  loggertestcase.cpp
  vectorappender.cpp
)
target_link_libraries(testsuite log4cxx ${APR_LIBRARY} ${APRutil_LIBRARY})

add_test(NAME consoleappender COMMAND testsuite consoleappendertestcase)
add_test(NAME logger COMMAND testsuite loggertestcase)
