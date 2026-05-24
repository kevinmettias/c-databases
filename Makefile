CC := cc
CMAKE := cmake
CFLAGS := -std=c11 -Wall -Wextra -Wpedantic -Werror -Ibench/include -Ibtree/include -Icommon/include -Ikv/include -Ilsm/include -Ipage/include -Itools/include -Itsdb/include -Iwal/include
LDFLAGS :=
LDLIBS := -lcmocka

BUILD_DIR := build
CORE_SRC := bench/src/bench.c btree/src/btree.c common/src/common.c kv/src/kv.c lsm/src/lsm.c page/src/page.c tools/src/tools.c tsdb/src/tsdb.c wal/src/wal.c
TESTS := $(BUILD_DIR)/test_bench $(BUILD_DIR)/test_btree $(BUILD_DIR)/test_common $(BUILD_DIR)/test_kv $(BUILD_DIR)/test_lsm $(BUILD_DIR)/test_page $(BUILD_DIR)/test_tools $(BUILD_DIR)/test_tsdb $(BUILD_DIR)/test_wal

.PHONY: all test clean dirs

all: dirs $(TESTS)

dirs:
	$(CMAKE) -E make_directory $(BUILD_DIR)
$(BUILD_DIR)/test_bench: $(CORE_SRC) bench/tests/test_bench.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) bench/tests/test_bench.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_btree: $(CORE_SRC) btree/tests/test_btree.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) btree/tests/test_btree.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_common: $(CORE_SRC) common/tests/test_common.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) common/tests/test_common.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_kv: $(CORE_SRC) kv/tests/test_kv.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) kv/tests/test_kv.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_lsm: $(CORE_SRC) lsm/tests/test_lsm.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) lsm/tests/test_lsm.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_page: $(CORE_SRC) page/tests/test_page.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) page/tests/test_page.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_tools: $(CORE_SRC) tools/tests/test_tools.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) tools/tests/test_tools.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_tsdb: $(CORE_SRC) tsdb/tests/test_tsdb.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) tsdb/tests/test_tsdb.c -o $@ $(LDFLAGS) $(LDLIBS)
$(BUILD_DIR)/test_wal: $(CORE_SRC) wal/tests/test_wal.c | dirs
	$(CC) $(CFLAGS) $(CORE_SRC) wal/tests/test_wal.c -o $@ $(LDFLAGS) $(LDLIBS)
test: $(TESTS)
	$(BUILD_DIR)/test_bench
	$(BUILD_DIR)/test_btree
	$(BUILD_DIR)/test_common
	$(BUILD_DIR)/test_kv
	$(BUILD_DIR)/test_lsm
	$(BUILD_DIR)/test_page
	$(BUILD_DIR)/test_tools
	$(BUILD_DIR)/test_tsdb
	$(BUILD_DIR)/test_wal

clean:
	rm -rf $(BUILD_DIR)
