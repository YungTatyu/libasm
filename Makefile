NAME				:= libasm.a
EXEC				:= a.out

SRCS_DIR			:= src
OBJS_DIR			:= obj
ROOT_DIR			:= $(shell pwd)
TEST_DIR			:= test
BUILD_DIR			:= $(TEST_DIR)/build

AS := nasm
ASFLAGS := -f elf64
AR := ar rcs
LD := ld
RM				:= rm -rf

SRC_EXT := s
VPATH := $(SRCS_DIR)

SRCS := $(wildcard $(addsuffix /*.$(SRC_EXT), $(VPATH)))
OBJS := $(patsubst $(SRCS_DIR)/%.$(SRC_EXT),$(OBJS_DIR)/%.o,$(SRCS))
INCLUDES := -I$(SRCS_DIR)

all: $(OBJS_DIR) $(NAME) $(EXEC)

$(NAME): $(OBJS)
	$(AR) $@ $^

$(EXEC): $(OBJS_DIR)/main.o $(NAME)
	$(LD) -o $@ $^

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.$(SRC_EXT)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJS_DIR)/main.o: main.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJS_DIR):
	mkdir -p $@

clean:
	$(RM) $(OBJS_DIR) $(BUILD_DIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

TEST_FILTER ?= '*'
test:
	cmake -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR)
	$(BUILD_DIR)/gtest-googletest --gtest_filter=$(TEST_FILTER)

.PHONY: all clean fclean re test debug
