#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH	 640
#define FRAME_HEIGHT 480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"

char ENDP[] = "*****End Print***** \n\n";

//extern void NAME();
//extern void ID();
//extern void drawJuliaSet();
extern Team, Name1, Name2, Name3;
extern num1, num2, num3, sum;

int main()
{
    //RGB16
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;

    printf( "Function1: Name\n" );
    NAME();

    printf( "Function2: ID\n" );
    ID();

    printf( "\nMain Function:\n*****Print All*****\n" );

    printf( "%s", &Team );
    printf( "%d %s", num1, &Name1 );
    printf( "%d %s", num2, &Name2 );
    printf( "%d %s", num3, &Name3 );
    printf( "ID Summation = %d\n", sum );

    printf( "*****End Print***** \n\n" );

    printf( "\n***** Please enter p to draw Julia Set animation *****\n" );

	while( getchar()!='p' ) ;
	system( "clear" );

	fd = open( FRAME_BUFFER_DEVICE, ( O_RDWR | O_SYNC ) );

	if( fd < 0 ) printf( "Frame Buffer Device Open Error!!\n" );
	else {

      for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {

		drawJuliaSet( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );

		write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );

        lseek( fd, 0, SEEK_SET );

      } // for

      printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
      printf( "by %s\n", &Team );
      printf( "%d  %s", num1, &Name1 );
      printf( "%d  %s", num2, &Name2 );
      printf( "%d  %s", num3, &Name3 );

      close( fd );
	} // else

    printf( "\n\npress p to end\n" );
	while(getchar()!='p') ;


    return 0;
}

