# IBM-PC汇编语言程序设计

## 使用方法

* step1：汇编 MASM.EXE  EXP.ASM
* step2：连接 LINK.EXE  EXP.OBJ
* step3：调试 DEBUG.EXE  EXP.EXE
* 直接执行可执行程序：在DOS窗口直接输入EXP.EXE即可。

## 编号说明

- ASS编号为作业编号
- EXP编号为例程编号
- EXE编号为课后练习编号

## 内容简介

##### 这个仓库中的程序主要记载了X86汇编语言程序设计的练习。

其中Assignment1-4包含了作业，Exercises则包含了练习代码

* EXP41.ASM 为升序排序示例程序
* ASS1-1.ASM 将升序修改为了降序
* ASS1-2.ASM  实现了将16进制数按10进制ASCII码输出
* ASS1-3.ASM  实现了32位数的乘法并以2进制形式输出
* EXP5-7.ASM 采用了更好的解决方案实现将16进制数按10进制ASCII码输出
* EXE5-1.ASM 为第5章作业第一题
* EXE5-2.ASM 为第5章作业第二题
* EXP9-5.ASM 实现了输入与输出的中断调用，从键盘读入字符串，若为小写字母可转换为大写字母输出
* ASS2-1.ASM 实现了从键盘读入两个3位十进制数计算乘法并显示
* ASS2-2.ASM 练习了字符串的各种操作与跳转表
* EXP6-3.ASM 实现了比较两个字符串的大小（按字典序）
* EXP5-9.ASM 实现了冒泡排序，为字典序的实现打下基础
* ASS2-3.ASM 实现了定长字符串的字典序排序
* ASS3-1.ASM 实现了递归计算N！并将结果RESULT作为参数向递归调用函数中传递
* ASS3-2.ASM 练习了子程序两种参数传递方式-寄存器传参和堆栈传参
* ASS4-1.ASM 练习了字符串查找、字符串中删除指定字符（快慢指针）
* ASS4-2.ASM 练习了字符的输入输出，数字读入存储逻辑，数字的最优输出方式
* ASS4-3.ASM 练习了0AH号中断调用读入字符串的操作，以及字符串拼接与拷贝操作
* ASS4-4.ASM 练习了16进制输出的方式（数字与字符时间的转换以及2号中断调用输出字符）
