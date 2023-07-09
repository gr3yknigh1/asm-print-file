global _start


%define UNIX_FD_STDIN	0
%define UNIX_FD_STDOUT	1
%define UNIX_FD_STDERR	2

%define EXIT_SUCCESS	0
%define EXIT_FAILURE	1


%define SYSCALL_READ	0
%define SYSCALL_WRITE	1
%define SYSCALL_EXIT	60


%define BUF_SIZE	64

segment .text
_start:
	mov	rax, SYSCALL_WRITE
	mov	rsi, S0
	mov	rdx, S0_L
	mov	rdi, UNIX_FD_STDOUT
	syscall

	mov	rax, UNIX_FD_STDIN
	mov	rsi, B0
	mov	rdx, BUF_SIZE
	syscall

	mov	rax, SYSCALL_WRITE
	mov	rsi, B0
	mov	rdx, BUF_SIZE
	mov	rdi, UNIX_FD_STDOUT
	mov	rsi, msg
	mov	rdx, ln

	syscall

	; Exit
	mov	rdi, EXIT_SUCCESS
	mov	rax, SYSCALL_EXIT
	syscall

segment .data
	S0	db	"Enter your name, please: ", 0
	S0_L	equ	$-S0

segment .bss
	B0	resb	BUF_SIZE
