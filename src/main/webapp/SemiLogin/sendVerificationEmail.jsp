<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="util.SHA256"%>
<%@page import="util.Gmail"%>
<%@page import="java.io.PrintWriter"%>

<%
    // 폼에서 입력받은 이메일 주소 가져오기
    String recipientEmail = request.getParameter("email");

    // 이메일 주소가 비어 있으면 오류 메시지 반환
    if (recipientEmail == null || recipientEmail.isEmpty()) {
        response.setStatus(400); // Bad request
        out.println("이메일 주소를 입력하세요.");
        return;
    }

    // 이메일 전송을 위한 설정
    Properties props = new Properties();
    props.put("mail.smtp.user", "dustmqdyd67@gmail.com"); // 보내는 이메일 주소
    props.put("mail.smtp.host", "smtp.googlemail.com"); // Gmail SMTP 주소
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.auth", "true");

    try {
        // SMTP 서버로 세션 생성
        Session sess = Session.getInstance(props, new Gmail());

        // 이메일 내용 구성
        String verificationCode = new SHA256().getSHA256(recipientEmail);
        String host = "http://localhost:8080/Lecture_Evaluation/";
        String subject = "비밀번호 찾기";
        String content = "링크에 접속해 이메일 인증을 진행해주세요." +
            "<a href='" + host + "emailCheckAction.jsp?code=" + verificationCode + "'>이메일 인증하기</a>";

        // 이메일 메시지 생성 및 설정
        MimeMessage message = new MimeMessage(sess);
        message.setSubject(subject);
        message.setFrom(new InternetAddress("dustmqdyd67@gmail.com")); // 보내는 이메일 주소
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail)); // 받는 이메일 주소
        message.setContent(content, "text/html;charset=UTF-8");

        // 이메일 전송
        Transport.send(message);

        out.println("이메일을 성공적으로 보냈습니다.");
    } catch (Exception e) {
        response.setStatus(500); // Internal server error
        e.printStackTrace();
        out.println("이메일 전송 중 오류가 발생했습니다.");
    }
%>
 --%>