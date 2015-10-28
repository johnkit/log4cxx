include_directories(
  ${APR_INCLUDE_DIR}
  ${APRutil_INCLUDE_DIR}
  ${PROJECT_BINARY_DIR}
  $${PROJECT_SOURCE_DIR}/src/main/include
)

file(GLOB_RECURSE TEST_SOURCES LIST_DIRECTORIES false *.cpp)

add_executable(testsuite
  ${TEST_SOURCES}
)
target_link_libraries(testsuite log4cxx ${APR_LIBRARY} ${APRutil_LIBRARY})

set(TEST_NAMES
  asyncappendertestcase
  consoleappendertestcase
  xloggertestcase
  odbcappendertestcase
  encodingtest
  fileappendertestcase
  filetestcase
  absolutetimedateformattestcase
  cacheddateformattestcase
  charsetdecodertestcase
  charsetencodertestcase
  cyclicbuffertestcase
  datetimedateformattestcase
  inetaddresstestcase
  iso8601dateformattestcase
  messagebuffertest
  optionconvertertestcase
  propertiestestcase
  relativetimedateformattestcase
  stringhelpertestcase
  stringtokenizertestcase
  syslogwritertest
  timezonetestcase
  transcodertestcase
  hierarchytest
  hierarchythresholdtestcase
  l7dtestcase
  leveltestcase
  loggertestcase
  minimumtestcase
  ndctestcase
  sockethubappendertestcase
  syslogappendertestcase
  telnetappendertestcase
  patternparsertestcase
  patternlayouttest
  propertyconfiguratortest
  filenamepatterntestcase
  filterbasedrollingtest
  manualrollingtest
  obsoletedailyrollingfileappendertest
  obsoleterollingfileappendertest
  sizebasedrollingtest
  timebasedrollingtest
  rollingfileappendertestcase
  streamtestcase
  levelmatchfiltertestcase
  levelrangefiltertestcase
  customleveltestcase
  domtestcase
  xmllayouttest
  xmllayouttestcase
)

foreach(name ${TEST_NAMES})
  add_test(
    NAME ${name}
    COMMAND testsuite ${name}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/src/test/resources
  )
endforeach()
