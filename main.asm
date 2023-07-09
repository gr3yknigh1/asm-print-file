global _start


%define UNIX_FD_STDIN	0
%define UNIX_FD_STDOUT	1
%define UNIX_FD_STDERR	2

%define EXIT_SUCCESS	0
%define EXIT_FAILURE	1


%define SYSCALL_READ	0
%define SYSCALL_WRITE	1
%define SYSCALL_OPEN	2
%define SYSCALL_CLOSE	3
%define SYSCALL_EXIT	60


%define BUF_SIZE	64

SEGMENT .text

_start:
	; Printing 'Openning file: '
	mov	rax, SYSCALL_WRITE
	mov	rsi, L2			; 'Openning a file: '
	mov	rdx, L3			;  ^^^^^^^^^^^^^^^^^ - size
	mov	rdi, UNIX_FD_STDOUT
	syscall

	; Printing './file.txt'
	mov	rax, SYSCALL_WRITE
	mov	rsi, L0			; './file.txt'
	mov	rdx, L1			;  ^^^^^^^^^^ - size
	mov	rdi, UNIX_FD_STDOUT
	mov	rsi, msg
	mov	rdx, ln

	syscall

	; Printing new line
	mov	rax, SYSCALL_WRITE
	mov	rsi, L4			; '\n'
	mov	rdx, 1
	mov	rdi, UNIX_FD_STDOUT
	syscall

	; Openning a file
	mov	rax, SYSCALL_OPEN
	mov	rdi, L0			; File path
	xor	rsi, rsi		; O_RDONLY
	syscall

	; Help, idk what I'm doing
	push	rax			; Push file descriptor
	sub	rsp, BUF_SIZE		; Reserver 16 bytes of memory for file content

	; Reading the file
	mov	rax, SYSCALL_READ
	mov	rdi, [rsp + BUF_SIZE]	; Get file descriptor from stack
	mov	rsi, rsp		; Address of reserved memory
	mov	rdx, BUF_SIZE
	syscall

	; Printing file content
	mov	rax, SYSCALL_WRITE
	mov	rsi, rsp		; File's content buffer
	mov	rdx, BUF_SIZE		; File's buffer size
	mov	rdi, UNIX_FD_STDOUT
	syscall

	; Closing a file
	mov	rax, SYSCALL_CLOSE
	mov	rdi, [rsp + BUF_SIZE]	; File's descriptor value
	syscall

	; Exiting with 0 exit code
	mov	rax, SYSCALL_EXIT
	mov	rdi, EXIT_SUCCESS
	mov	rax, SYSCALL_EXIT
	syscall

SEGMENT .data
	L0	db	"./file.txt", 0
	L1	equ	$-L0
	L2	db	"Openning file: ", 0
	L3	equ	$-L2
	L4	db	10

