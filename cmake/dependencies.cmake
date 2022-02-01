# Find the Xerces libraries
set(Xerces_USE_STATIC_LIBS ON)
find_package(XercesC 3.2 REQUIRED)
set(XML_LIBRARIES ${XercesC_LIBRARIES})
set(XML_INCLUDE_DIRS ${XercesC_INCLUDE_DIRS})
list(APPEND compiler_definitions XERCES_STATIC_LIBRARY)
  
# Add ICU in Linux Systems
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux" OR ${CMAKE_SYSTEM_NAME} STREQUAL "Apple")
  list(APPEND compiler_definitions LINUX)
  find_package(ICU REQUIRED)
  set(XML_LIBRARIES ${XML_LIBRARIES} ${ICU_LIBRARIES})
  set(XML_INCLUDE_DIRS ${XML_INCLUDE_DIRS} ${ICU_INCLUDE_DIRS})
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
  list(APPEND compiler_definitions WINDOWS)
endif()
