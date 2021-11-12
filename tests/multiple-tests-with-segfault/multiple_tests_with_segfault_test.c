// Version: 1.1.0

#include "vendor/unity.h"

extern int add(int x, int y);
extern int sub(int x, int y);
extern int mul(int x, int y);

void setUp(void) {
}

void tearDown(void) {
}

void test_add(void) {
    TEST_ASSERT_EQUAL_INT(3, add(1, 1));
}

void test_sub(void) {
    TEST_ASSERT_EQUAL_INT(1, sub(2, 1));
}

void test_mul(void) {
    TEST_ASSERT_EQUAL_INT(7, mul(2, 3));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_add);
    RUN_TEST(test_sub);
    RUN_TEST(test_mul);
    return UNITY_END();
}
