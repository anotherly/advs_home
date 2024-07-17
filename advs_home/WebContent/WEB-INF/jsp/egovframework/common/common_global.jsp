<%-- Tag Lib Define --%>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<% pageContext.setAttribute("crlf","\r\n"); %>

<%--
-------------------------------------- SpEL (사용 예) : util:properties -------------------------------
---   1. 자바에서 사용하는 법
---      @Value("#{nhtmsProperties['key']}") String key;
---   2. applicationContext.xml과 같은 *.xml에서 사용하는 법
---      <bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close">
---      <property value="#{nhtmsProperties['key']}" name="driverClassName"></property>
---      </bean>
---    3. JSP에서 사용하는 방법
---      <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
---      <spring:eval expression="@nhtmsProperties['key']"></spring:eval>
-------------------------------------- SpEL (사용 예) : util:properties  ------------------------------- 
 --%>
 
<%-- URL을 통해 해더 메뉴 분기를 위한 설정 시작 --%>

<%-- URL을 통해 해더 메뉴 분기를 위한 설정 끝 --%>


