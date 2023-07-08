global _start


%define UNIX_FD_STDIN	0
%define UNIX_FD_STDOUT	1
%define UNIX_FD_STDERR	2

%define EXIT_SUCCESS	0
%define EXIT_FAILURE	1

%define SYSCALL_WRITE	1
%define SYSCALL_EXIT	60

segment .text
_start:
	mov	rax, SYSCALL_WRITE
	mov	rdi, UNIX_FD_STDOUT
	mov	rsi, msg
	mov	rdx, ln

	syscall

	; Exit
	mov	rdi, EXIT_SUCCESS
	mov	rax, SYSCALL_EXIT
	syscall

segment .data
	msg	db	'word', 10, 0
	ln	equ	$-msg
