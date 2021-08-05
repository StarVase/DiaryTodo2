package com.StarVase.library.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.Scanner;

class ReadText implements Runnable {
	private String FilePath;// 文件路径
	private int Start;// 开始读取的行
	private int end;// 结束读取的行
	private int i;// 当前线程
	// 有参构造方法

	public ReadText(String FilePath, int Start, int end, int i) {
		this.FilePath = FilePath;
		this.Start = Start;
		this.end = end;
		this.i = i;
	}

	@Override
	public void run() {
		// 同步代码块共享资源
		synchronized (this) {
			Read();

		}
	}

	public synchronized void Read() {
		try {
			int Numline = 0;
			LineNumberReader br = new LineNumberReader(
					new BufferedReader(new InputStreamReader(new FileInputStream(FilePath), "GBK")));
			String strline = null;
			while ((strline = br.readLine()) != null) {
				Numline++;
				if (Start < Numline) {
					System.out.println("线程:" + i + "内容：" + strline);
					if (Numline == end) {
						break;
					}
				}
			}
			;
			br.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

public class ThreadReader {

	public static void main(String[] args) {
		// 获取控制台
		Scanner scan1 = new Scanner(System.in);
		System.out.println("请输入Text文件路径：");
		String FilePath = scan1.next();
		System.out.println("请输入读取的线程数：（1~64）");
		int ThreadNum = scan1.nextInt();
		//获取行数
		int iNum = Readline(FilePath);
		// 启动线程时的判断
		int Readline = iNum / ThreadNum;
		int Startline = 0;// 在哪读取
		int endline = 0;// 在哪结束
		long Time = 0;// 用时
		long StartTime = System.currentTimeMillis();
		//开启多线程读取文本行数
		ThreadReadTextLine(iNum, Readline, Startline, endline, ThreadNum, FilePath);
		long EndTime = System.currentTimeMillis();
		Time = (EndTime - StartTime);
		//打印用时
		System.out.println("线程结束！用时：" + Time + "毫秒");
	}
	/**
	 * 多线程读取文件
	 * @param iNum，映射行数
	 * @param Readline，映射每个线程需读取行数
	 * @param Startline，映射一个线程开始行数
	 * @param endline，映射一个线程结束的行数
	 * @param ThreadNum，映射线程数
	 * @param FilePath，映射文件路径
	 */
	public static void ThreadReadTextLine(int iNum,int Readline,int Startline,int endline,int ThreadNum,String FilePath) {
		// 判断读取行数奇偶性与行数是否大于线程数
				if (iNum % ThreadNum == 0 && !(iNum < ThreadNum)) {
					// 启动线程
					System.out.println("开始读取！");
					// 开始的时间
					for (int i = 0; i < ThreadNum; i++) {
						Startline = Readline * i;// 计算开始读取的行数
						endline = Startline + Readline;// 计算末尾读取的行数
						// 传入重要参数，行数，文件路径，开始行数，结束行数，当前线程
						ReadText rt = new ReadText(FilePath, Startline, endline, (i + 1));
						Thread t = new Thread(rt);
						t.start();
					}
				}
	}
	/**
	 * 读取Text文件行数
	 * @param FilePath,映射文件目录
	 * @return iNum
	 */
	public static int Readline(String FilePath) {
		// 读取用缓冲流线程行数
		int iNum = 0;// 行数
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(FilePath)));
			String strline = null;// 临时存取
			while ((strline = br.readLine()) != null) {
				iNum++;
			}
			br.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return iNum;
	}

}
