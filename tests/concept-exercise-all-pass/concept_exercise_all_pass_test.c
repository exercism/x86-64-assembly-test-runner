#include "vendor/unity.h"

extern int add(int a, int b);
extern int mul(int a, int b);

void setUp(void) { }
void tearDown(void) { }

// TASK: 1
void test_add(void) {
    TEST_ASSERT_EQUAL_INT(2, add(1, 1));
}

void test_add_negative(void) {
    TEST_ASSERT_EQUAL_INT(-1, add(1, -2));
}

// TASK: 2
void test_mul(void) {
    TEST_ASSERT_EQUAL_INT(6, mul(2, 3));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_add);
    RUN_TEST(test_add_negative);
    RUN_TEST(test_mul);
    return UNITY_END();
}
