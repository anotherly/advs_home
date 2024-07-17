package katri.avsc.com.scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.com.core.Mail;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.TaskService;

/**
 * @Class Name : JobTask.java
 * @Description : JobTask Class
 * @Modification Information
 * @
 * scheduler를 이용한 job class
 * @author jwchoi
 * @version 1.0
 *
 */

@Component
public class JobTask extends QuartzJobBean {

	private static final Log LOG = LogFactory.getLog(JobTask.class.getName());

	private ApplicationContext ctx;
	//private MainService mainService;

	private String name;
	public void setName(String name) {
		this.name = name;
	}

	@Override
	protected void executeInternal(JobExecutionContext ex) throws JobExecutionException {
		ctx = (ApplicationContext) ex.getJobDetail().getJobDataMap().get("applicationContext");
		executeJob(ex);
	}

	private void executeJob(JobExecutionContext ex) {
		LOG.debug(" ########## JobTask.executeJob ###########");
		TaskService taskService = (TaskService) ctx.getBean("taskService");
		EgovPropertyService propertiesService = (EgovPropertyService) ctx.getBean("propertiesService");

		Map<String, String> map = new HashMap<String, String>();

		Map<String, String> scheInfo = taskService.selectScheInfo(map);
		String data1 = Util.nvl(scheInfo.get("data1"));
		String data2 = Util.nvl(scheInfo.get("data2"));
		LOG.debug(" ##################### : executeJob " + data1);

		if(!data1.equals("") && !data2.equals("")) {
			try {
				String mailHost = propertiesService.getString("mailHost");	//smtp host
				String mailPort = propertiesService.getString("mailPort");	//smtp port
				String mailUser = propertiesService.getString("mailUser");	//전송메일 계정
				String mailPwrd = propertiesService.getString("mailPwrd");
				String mailAdmn = propertiesService.getString("mailAdmn");	//담당자 메일

				Map<String, String> map01 = new HashMap<String, String>();
//				map01.put("data1", data1);
				map01.put("data1", "0701");
				List<?> drvList = taskService.selectDvrgRegList(map01);
				String subject = "알림메일 : 운행정보 등록 현황";
				String text = "[운행정보 등록현황입니다.] \n\n";
				for(int i=0; i < drvList.size(); i++) {
					EgovMap egovMap = (EgovMap)drvList.get(i);
					String seq = String.valueOf(i+1);
					//등록데이터
					String tmpRaceAgency = Util.nvl(String.valueOf(egovMap.get("tmpRaceAgency")));
					String tmpRaceNumber = Util.nvl(String.valueOf(egovMap.get("tmpRaceNumber")));
					String stndDtView = String.valueOf(egovMap.get("stndDtView"));
					String regDateView = String.valueOf(egovMap.get("regDateView"));
					String regDiv = String.valueOf(egovMap.get("regDiv"));
					LOG.debug(" ##################### : stndDtView " + stndDtView + "----------" + regDateView + "===========" + regDiv);
					String view = tmpRaceNumber.equals(regDiv) ? "등록일 : "+regDateView : regDiv ;
					text += "[ "+view+" ] " + tmpRaceAgency + "( " +tmpRaceNumber+ " )" + "\n";
				}
				Mail.mailSend(mailHost, mailPort, mailUser, mailPwrd, mailAdmn, subject, text);

			} catch (Exception e) {
				LOG.info("[executeJob Exception] executeJob 실패 : " + e.toString());
			}
		}
	}

/*
 * 최초 작성 scheduler
	@Override
	protected void executeInternal (JobExecutionContext ctx) throws JobExecutionException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("level", "1");
		List<?> linkList1 = mainService.selectVertexArea1(map);
		LOG.debug(" JobTask-linkList1["+linkList1+"]");
		ConstantsDefine.GW_LINK_LV1 = (List<Map<String, String>>)linkList1;
	}
*/
	 
}