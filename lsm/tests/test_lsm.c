#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>

static void Lsm_Placeholder_Test(void **state)
{
    (void)state;
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(Lsm_Placeholder_Test),
    };

    return cmocka_run_group_tests(tests, NULL, NULL);
}
