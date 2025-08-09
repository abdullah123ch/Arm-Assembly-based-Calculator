# ARM Assembly-based Calculator

A simple calculator implementation using ARM assembly language with a C interface. This project demonstrates basic arithmetic operations (addition, subtraction, multiplication, and division) implemented in ARM assembly and called from a C program.

## Features

- **Basic Arithmetic Operations**:
  - Addition (+)
  - Subtraction (-)
  - Multiplication (*)
  - Division (/)
- **Error Handling**:
  - Division by zero detection
  - Invalid operation handling
- **Cross-Platform**: Can be run on ARM devices or emulated using QEMU

## Prerequisites

To build and run this project, you'll need:

- ARM cross-compiler toolchain (arm-linux-gnueabi-gcc)
- QEMU for ARM (for running on non-ARM systems)
- Make

### Installation on Ubuntu/Debian

```bash
sudo apt update
sudo apt install gcc-arm-linux-gnueabi qemu-user make
```

## Building the Project

1. Clone the repository (if not already done):
   ```bash
   mkdir Calculator
   cd Calculator
   git clone https://github.com/abdullah123ch/Arm-Assembly-based-Calculator.git
   ```

2. Build the project:
   ```bash
   make
   ```

   This will compile both the C and ARM assembly code and link them together into an executable named `calc`.

## Running the Calculator

After building, you can run the calculator using QEMU:

```bash
make run
```

Or directly with QEMU:

```bash
qemu-arm ./calc
```

## Usage

1. Run the program
2. Enter the first number
3. Choose an operation (+, -, *, /)
4. Enter the second number
5. View the result

Example:
```
Enter first number: 10
Enter operation (+ - * /): *
Enter second number: 5
Result: 50
```

## Project Structure

- `main.c`: C program that provides the user interface and calls the assembly functions
- `calc.s`: ARM assembly implementation of the arithmetic operations
- `Makefile`: Build configuration for compiling and running the project

## Implementation Details

- The calculator uses ARMv7-A architecture instructions
- Division is implemented using a shift-subtract algorithm in assembly
- The C interface handles user input/output and error checking
- The project is built as a static binary for ARM architecture

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

*Note: This project was created for educational purposes to demonstrate ARM assembly programming and C-ASM interoperability.*
