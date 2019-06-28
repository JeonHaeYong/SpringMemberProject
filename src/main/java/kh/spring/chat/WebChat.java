package kh.spring.chat;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value="/chat", configurator=HttpSessionSetter.class)
public class WebChat {
//	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	private static Map<Session, String> clients = Collections.synchronizedMap(new HashMap<Session, String>());
	@OnMessage
	public void onMessage(String message, Session session) throws Exception {
		String loginId = clients.get(session);
		System.out.println(loginId);
		synchronized (clients) {
			for(Session each : clients.keySet()) {
				if(each != session) {
					each.getBasicRemote().sendText(loginId + ": " + message);
				}
			}
		}
	}

	@OnOpen
	public void onOpen(Session session, EndpointConfig ec) throws Exception {
		HttpSession hsession = (HttpSession)ec.getUserProperties().get("httpSession");
		String loginId = (String)hsession.getAttribute("loginId");
		System.out.println(loginId);
		System.out.println("접속자발생");
		synchronized (clients) {
			for(Session each : clients.keySet()) {
				if(each != session && loginId !=null) {
					each.getBasicRemote().sendText(loginId + "님이 참여하셨습니다.");
				}
			}
		}
		clients.put(session, loginId);
	}

	@OnClose
	public void onClose(Session session) throws Exception {
		String remove = clients.remove(session);
		synchronized (clients) {
			for(Session each : clients.keySet()) {
				if(each != session && remove !=null) {
					each.getBasicRemote().sendText(remove + "님이 나갔습니다.");
				}
			}
		}
		System.out.println(remove);
	}
}
