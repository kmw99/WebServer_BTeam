<%@ page language="java" import="java.io.*, java.time.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
		public void writeLog( String message, HttpServletRequest request, HttpSession session )
		{
			if(message == null) message = "null"
			try 
			{
				// 로그 파일 : ex) /var/lib/tomcat8/webapps/ROOT/book/jsp/log.txt, /usr/local/tomcat/webapps/ROOT/book/jsp/log.txt
				final String logFileName = "/var/lib/tomcat10/webapps/ROOT/WebServer_BTeam/HTML/log.txt";	 
				BufferedWriter writer = new BufferedWriter( new FileWriter( logFileName, true ) );

				// 로그 데이터 출력
				writer.append( "\nTime:\t" + LocalDate.now() + " " + LocalTime.now() 	// 접속 시간	
					+ "\tSessionID:\t" + (session != null ? session.getId() : "NoSession")
					+ "\tURI:\t" + (request != null ? request.getRequestURI() : "NoRequest")
					+ "\tPrevious:\t" + (request != null ? request.getHeader("referer") : "NoReferer")
					+ "\tBrowser:\t" + (request != null ? request.getHeader("User-Agent") : "NoUserAgent")
					+ "\tMessage:\t" + message);

				writer.close();
			} 
			// 예외 처리
			catch (IOException e) 
			{
				e.printStackTrace();
			}
		}
	%>


<%-- 
	<%!
		public void writeLog( String message, HttpServletRequest request, HttpSession session )
		{
			try 
			{
				// 로그 파일 : ex) /var/lib/tomcat8/webapps/ROOT/book/jsp/log.txt, /usr/local/tomcat/webapps/ROOT/book/jsp/log.txt
				final String logFileName = "/var/lib/tomcat10/webapps/ROOT/WebServer_BTeam/HTML/log.txt";	 
				BufferedWriter writer = new BufferedWriter( new FileWriter( logFileName, true ) );

				// 로그 데이터 출력
				writer.append( "\nTime:\t" + LocalDate.now() + " " + LocalTime.now() 	// 접속 시간	
					+ "\tSessionID:\t" + session.getId()				// 접속 ID	
					+ "\tURI:\t" + request.getRequestURI()				// 현재 페이지 
					+ "\tPrevious:\t" + request.getHeader("referer") 		// 접속 경로(이전페이지)
					+ "\tBrowser:\t" + request.getHeader("User-Agent") 		// 접속 브라우저	
					+ "\tMessage:\t" + message );

				writer.close();
			} 
			// 예외 처리
			catch (IOException e) 
			{
				e.printStackTrace();
			}
		}
	%>
--%>

<%-- 
	<%!
	public synchronized void writeLog(String message, HttpServletRequest request, HttpSession session) {
		if(message == null) message = "null";
		try {
			String logFileName = application.getRealPath("/log.txt");
			BufferedWriter writer = new BufferedWriter(new FileWriter(logFileName, true));
			writer.append("\nTime:\t" + LocalDate.now() + " " + LocalTime.now()
				+ "\tSessionID:\t" + (session != null ? session.getId() : "NoSession")
				+ "\tURI:\t" + (request != null ? request.getRequestURI() : "NoRequest")
				+ "\tPrevious:\t" + (request != null ? request.getHeader("referer") : "NoReferer")
				+ "\tBrowser:\t" + (request != null ? request.getHeader("User-Agent") : "NoUserAgent")
				+ "\tMessage:\t" + message);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	%>
--%>