package com.laonmoa.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.channels.Channel;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

public class SFTPUploader {

	private Session session = null;
	private Channel channel = null;
	private ChannelSftp channelSftp = null;
	private String url = "iup.cdn3.cafe24.com";
	private String user = "hoohee0331";
	private String password = "moalaon55*";
	private int port = 21;
	String dir = "www/resource";

	// SFTP 서버연결
	public void init() {
		//JSch 객체 생성
		JSch jsch = new JSch();
		try {
			//세션객체 생성 ( user , host, port )
			session = jsch.getSession(user, url, port);

			//password 설정
			session.setPassword(password);

			//호스트 정보 검사하지 않는다.

			java.util.Properties config = new java.util.Properties();

			config.put("StrictHostKeyChecking", "no");

			session.setConfig(config);

			session.connect();

			//sftp 채널 접속
			channel = (Channel) session.openChannel("sftp");
			((Session) channel).connect();

		} catch (JSchException e) {
			e.printStackTrace();
		}
		channelSftp = (ChannelSftp) channel;

	}

	// 단일 파일 업로드
	public void upload(File file) {

		FileInputStream in = null;
		try { // 파일을 가져와서 inputStream에 넣고 저장경로를 찾아 put
			in = new FileInputStream(file);
			channelSftp.cd(dir);
			channelSftp.put(in, file.getName());
		} catch (SftpException se) {
			se.printStackTrace();
		} catch (FileNotFoundException fe) {
			fe.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
	}

	public void mkdir(String path) throws SftpException {
		ChannelSftp channelSftp = (ChannelSftp) channel;
		SftpATTRS attrs = null;
		try {
			attrs = channelSftp.stat(path);
		} catch (Exception e) {
			System.out.println(path + " not found");
		}
		if (attrs != null) {
			System.out.println("Directory exists IsDir=" + attrs.isDir());
		} else {
			System.out.println("Creating dir " + path);
			channelSftp.mkdir(path);
		}
	}

	// 파일서버와 세션 종료
	public void disconnect() {
		channelSftp.quit();
		session.disconnect();
	}
}