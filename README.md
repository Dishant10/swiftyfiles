# swiftyfiles

***
Experience the ultimate file management solution with our Swift-based command line tool, designed to make your life easier. With its dual functionality, this tool offers two distinct modes, catering to your specific needs.

In the first mode, enjoy the convenience of automated file segregation and saving based on extension. Eliminate the hassle of manual sorting and enjoy a clean and organized workspace.

In the second mode, ensure the safety and confidentiality of your sensitive information with our secure encryption and decryption feature. Share files without worry, knowing that your data is protected.

Whether you're a professional or casual user, this versatile tool offers a seamless and efficient solution to your file management needs. So why wait? Use the tool now and take control of your files like never before!

***

## Installation

### Prerequisites
 [Swift](https://www.swift.org/download/)

1.) Clone the repository:

```
git clone https://github.com/Dishant10/swiftyfiles
```
2.) Go to swiftyfiles directory

```
cd swiftyfiles
```
3.) Build and release swiftyfiles

```
swift build -c release
```
4.) Copy the swiftyfiles to your local bin folder

```
cp -f .build/release/swiftyfiles /usr/local/bin/swiftyfiles

```

After copying the executable file to the path specified above, you can access the swiftyfiles command from any directory on your system.
To ensure the changes take effect, consider restarting your terminal session.

## Note :- This only works on macOS version 13 and above.

Navigating through your system to access files can be a hassle. That's why we created a Swift-based tool that simplifies file management, allowing you to save time and effort.

With our tool at your fingertips, you can streamline your workflow and focus on what matters most. Say goodbye to tedious file management and download swiftyfiles now!

## Usage

1.) Encrytion and Decryption mode

To use the tool in encryption and decrytion mode specify the mode as 'e'. Mode is taken as an argument so it is mandatory to provide. 

### Example : -

a.) Encryption
```
swiftyfiles e -i /file/path -o /output/file/path -p Password 
```

b.) Decrytion
```
swiftyfiles e -i /file/path/to/decrypt -o /encrypted/output/file -p passwordUsedToEncrypt -d
```
Flag -d is used to specifiy to decrypt file

If you don't provide a password. Default password that is used while encryption and decryption is 'cipher101'.

2.) Sagregation of files based on their extensions.

To use the tool in saving mode you need to provide the mode argument as 's'. Mode is taken as an argument and is mandatory to provide.

### Example - 

```
swiftyfiles s -u /url/of/the/directory/in/which/you/need/to/manage/files
```
This command will do its magic. During execution it will ask some question like the file type you want to separate and the folder name you want to save the seperated files.


  
