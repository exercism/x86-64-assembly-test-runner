// Version: 1.1.0

#include "vendor/unity.h"

extern int add(int x, int y);

void setUp(void) {
}

void tearDown(void) {
}

void test_add(void) {
    TEST_ASSERT_EQUAL_INT(3, add(1, 1));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_add);
    return UNITY_END();
}
