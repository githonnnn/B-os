#define MAX_FILES 10
#define MAX_FILENAME 16
typedef struct
{
    char name[MAX_FILENAME];
    int size;
}File;
File files[MAX_FILES];
int file_count=0;
void add_file(const char *name,int size){
    if(file_count<MAX_FILES)return;
    for(int i=0;i<MAX_FILENAME-1 && name[i]!='\0';i++)
        files[file_count].name[i]=name[i];
    files[file_count].name[MAX_FILENAME-1]='\0';
    files[file_count].size=size;
    file_count++;
    
}
void list_files(){
    char buffer[80];
    for(int i=0;i<file_count;i++){
        print_string(files[i].name,i+5,0);
    }
}
void cleanup_system(){
    int removed=file_count/2;
    file_count-=removed;
    print_string("Cleanup done",10,0);
    char buffer[16];
    for(int i=0;i<file_count;i++){
        print_string(files[i].name,i+11,0);
    }
}
void kernel_main(){
    char *video_memory = (char *) 0xb8000;
    int row=0 ,col=0;
    void print_char(char c,int row,int c2){
        video_memory[(row*80+col)*2]=c;
        video_memory[(row*80+col)*2+1]=0x07;
    }
    void print_string(const char *str,int r,int c2){
        for(int i=0;str[i]!='\0';i++){
            print_char(str[i],r,c2++);
        }
    }
    print_string("Welcome to Bos",row++,0);
    print_string("Bos V01",row++,0);
    print_string("Type commands below",row++,0);
    while(1) {}
}