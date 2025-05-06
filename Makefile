NAME				:= libasm.a

SRCS_DIR			:= src
OBJS_DIR			:= obj
DEPS_DIR			:= dep
ROOT_DIR			:= $(shell pwd)
TEST_DIR			:= test
BUILD_DIR			:= $(TEST_DIR)/build

AS := nasm
ASFLAGS := -f elf64
AR := ar rcs
RM				:= rm -rf

SRC_EXT := s
VPATH := $(SRCS_DIR)

SRCS := $(wildcard $(addsuffix /*.$(SRC_EXT), $(VPATH)))
DEPS := $(patsubst $(SRCS_DIR)/%.cpp,$(DEPS_DIR)/%.d,$(SRCS))
OBJS := $(patsubst $(SRCS_DIR)/%.cpp,$(OBJS_DIR)/%.o,$(SRCS))
INCLUDES := -I$(SRCS_DIR)

all: $(DEPS_DIR) $(OBJS_DIR) $(NAME)

$(NAME): $(OBJS)
	$(AR) $@ $^

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.$(SRC_EXT)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(DEPS_DIR):
	mkdir -p $@

$(OBJS_DIR):
	mkdir -p $@

clean:
	$(RM) $(OBJS_DIR) $(DEPS_DIR) $(BUILD_DIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

TEST_FILTER ?= '*'
test:
	cmake -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR)
	$(BUILD_DIR)/gtest-googletest --gtest_filter=$(TEST_FILTER)

-include $(DEPS)

.PHONY: all clean fclean re test debug
