package katri.avsc.com.core;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileUtil {

	/** 다운로드 버퍼 크기 */
	private static final int BUFFER_SIZE = 8192; // 8kb
	  
	/** 문자 인코딩 */
	private static final String CHARSET = "utf-8";
	  
	private static final Log LOG = LogFactory.getLog(FileUtil.class.getName());

	//파일을 존재여부를 확인하는 메소드
	public static Boolean fileIsLive(String isLivefile) {
	  File f1 = new File(isLivefile);
	  
	  if(f1.exists()) {
		  return true;
	  } else {
		  return false;
	  }
	}
 
	//파일을 생성하는 메소드
	public static boolean fileMake(String path, String fileName) {
		File dir = new File(path); // ex) D:\temp\
		File fullFileName = new File(path+fileName);
		if(!dir.exists()){
			dir.mkdirs();
		}
		try {
			fullFileName.createNewFile();
			return true;
		}catch (IOException e) {
			LOG.info("[fileMake] 실패 : ");
			return false;
		}
	}
 
	//파일을 삭제하는 메소드
	public static boolean fileDelete(String deleteFileName) {
		File file = new File(deleteFileName);
		if (file.exists()) {
			if (file.delete()) {
				LOG.info("[fileDelete] 성공 : ");
				return true;
			} else {
				LOG.info("[fileDelete] 실패 : ");
				return false;
			}
		} else {
			LOG.info("[fileDelete] 없음 : ");
			return false;
		}
	}
 
	//파일을 복사하는 메소드
	public static boolean fileCopy(String inFileName, String outFileName) {
		LOG.debug("inFileName :: " + inFileName);
		LOG.debug("outFileName :: " + outFileName);
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(inFileName);
			fos = new FileOutputStream(outFileName);
		 
			int data = 0;
			while((data=fis.read())!=-1) {
				fos.write(data);
			}
		} catch (IOException e) {
			LOG.info("[fileCopy] 실패 : ");
		   return false;
		} finally {
			if(fis != null) try {fis.close();} catch (IOException e1) {LOG.info("[fileCopy] 실패2 : ");}
			if(fos != null) try {fos.close();} catch (IOException e1) {LOG.info("[fileCopy] 실패3 : ");}
		}
		return true;
	}

	//파일을 이동하는 메소드
	public static void fileMove(String inFileName, String outFilePath, String outFileName) {
		try {
			Path file = Paths.get(inFileName);
			Path movePath = Paths.get(outFilePath);
			Files.move(file , movePath.resolve(outFileName));
		} catch (IOException e) {
			LOG.info("[fileMove] 실패 : "+ e.toString());
		}
	}

	//파일 이름 변경 메소드
	public static void fileRename(String savePath, String infilename, String newFilename) {

		try {
			byte[] buf = new byte[1024];
			FileInputStream fin = null;
			FileOutputStream fout = null;
			 
			 
			File oldFile = new File(savePath + infilename);
			File newFile = new File(savePath + newFilename);
			 
			if(!oldFile.renameTo(newFile)){
			    buf = new byte[1024];
			    fin = new FileInputStream(oldFile);
			    fout = new FileOutputStream(newFile);
			 
			    int read = 0;
			    while((read=fin.read(buf,0,buf.length))!=-1){
			        fout.write(buf, 0, read);
			    }
			     
			    fin.close();
			    fout.close();
			    oldFile.delete();
			}
		} catch (Exception e) {
			LOG.info("[fileRename] 실패 : "+ e.toString());
		}
	}

	//디렉토리의 파일 리스트를 읽는 메소드
	public static List<File> getDirFileList(String dirPath) {
		// 디렉토리 파일 리스트
		List<File> dirFileList = null;
		// 파일 목록을 요청한 디렉토리를 가지고 파일 객체를 생성함
		File dir = new File(dirPath);
		// 디렉토리가 존재한다면
		if (dir.exists()){
			// 파일 목록을 구함
			File[] files = dir.listFiles();
			// 파일 배열을 파일 리스트로 변화함 
			dirFileList = Arrays.asList(files);
		}
		return dirFileList;
	}

	/**
	 * Multipart formdata 파일 을 destDir에 저장한다  
	 * @param multipartFile
	 * @param destDir
	 * @return
	 */	
	public static String transferUploadFile(MultipartFile multipartFile, String destDir) throws IOException {
		String originFileNm = "";
		if (multipartFile != null) {
			File dir = new File(destDir); // ex) D:\temp\
			if (!dir.exists()) {
				dir.mkdirs();
			}
			originFileNm = multipartFile.getOriginalFilename();
			/* 업로드 파일 이동 */
			try {
				multipartFile.transferTo(new File(destDir, originFileNm));
			} catch (IllegalStateException e) {
				e.printStackTrace();
     			LOG.info("[transferUploadFile] 실패1 : ");
			} catch (IOException e) {
				e.printStackTrace();
     			LOG.info("[transferUploadFile] 실패2 : ");
			}
			// System.out.println("Real Conf Dir-- ["+destDir+"]");
			// System.out.println("Real Conf originFileNm--
			// ["+originFileNm+"]");
		}
		return originFileNm;
	}

	/**
	 * Multipart formdata 파일 을 destDir에 저장한다  
	 * @param multipartFile
	 * @param destDir
	 * @return
	public static String transferUploadFile(MultipartFile multipartFile, String destDir) throws IOException {
		String originFileNm = "";
		if (multipartFile != null) {
			File dir = new File(destDir); // ex) D:\temp\
			if(!dir.exists()){
				dir.mkdirs();
			}
			originFileNm = multipartFile.getOriginalFilename();
			if( originFileNm != null ) {
				if(originFileNm.endsWith(".doc") || originFileNm.endsWith(".hwp") 
				|| originFileNm.endsWith(".pdf") || originFileNm.endsWith(".xls")
				|| originFileNm.endsWith(".jpg") || originFileNm.endsWith(".gif")
				|| originFileNm.endsWith(".png") || originFileNm.endsWith(".docx")
				|| originFileNm.endsWith(".pptx") || originFileNm.endsWith(".xlsx")) {
					 try {
						 if(originFileNm != null && !"".equals(originFileNm) ) {
							 originFileNm = originFileNm.replaceAll("/","");
							 originFileNm = originFileNm.replaceAll("\\\\","");
							 originFileNm = originFileNm.replaceAll(".","");
							 originFileNm = originFileNm.replaceAll("&","");
						 }
						 multipartFile.transferTo(new File(destDir, originFileNm));
		             } catch (IllegalStateException e) {
		            	e.printStackTrace();
		     			LOG.info("[transferUploadFile] 실패1 : ");
		             } catch (IOException e) {
		            	e.printStackTrace();
		      			LOG.info("[transferUploadFile] 실패2 : "+e.getMessage());
		             }
				} else {
					LOG.info("[transferUploadFile] 실패3 : file name error ");
				}
			}
			LOG.info("Real Conf Dir-- ["+destDir+"]");
			LOG.info("Real Conf originFileNm-- ["+originFileNm+"]");
		}
		return originFileNm;
	}
	 */	
	
	/**
	 * Multipart formdata 파일 을 destDir에 저장한다  
	 * @param multipartFile
	 * @param destDir
	 * @return
	 */	
	public static String transferUploadFile(MultipartFile multipartFile, String destDir, String newFileNm) throws IOException {
		String originFileNm = "";
		if (multipartFile != null) {
			File dir = new File(destDir); // ex) D:\temp\
			if(!dir.exists()){
				dir.mkdirs();
			}
			originFileNm = multipartFile.getOriginalFilename();
			/* 업로드 파일 이동 */
			 try {
				 multipartFile.transferTo(new File(destDir, newFileNm));
            } catch (IllegalStateException e) {
     			LOG.info("[transferUploadFile] 실패11 : ");
            } catch (IOException e) {
      			LOG.info("[transferUploadFile] 실패12 : ");
            }
			LOG.info("Real Conf Dir-- ["+destDir+"]");
			LOG.info("Real Conf originFileNm-- ["+originFileNm+"]");
		}
		return newFileNm;
	}

	/**
	 * Multipart formdata 파일 을 destDir에 origin name과 new name을 합쳐서 저장한다  
	 * @param multipartFile
	 * @param destDir
	 * @return
	 */	
	public static String transferUploadFileNew(MultipartFile multipartFile, String destDir, String newFileNm) throws IOException {
		String originFileNm = "";
		if (multipartFile != null) {
			File dir = new File(destDir); // ex) D:\temp\
			if(!dir.exists()){
				dir.mkdirs();
			}
			originFileNm = multipartFile.getOriginalFilename();
			newFileNm = newFileNm + originFileNm;
			/* 업로드 파일 이동 */
			 try {
				 multipartFile.transferTo(new File(destDir, newFileNm));
            } catch (IllegalStateException e) {
     			LOG.info("[transferUploadFileNew] 실패1 : ");
            } catch (IOException e) {
      			LOG.info("[transferUploadFileNew] 실패2 : ");
            }
			LOG.info("Real Conf Dir-- ["+destDir+"]");
			LOG.info("Real Conf originFileNm-- ["+newFileNm+"]");
		}
		return newFileNm;
	}

	/**
	* 지정된 파일을 다운로드 한다.
	* 
	* @param request
	* @param response
	* @param file 다운로드할 파일
	* @throws ServletException
	* @throws IOException
	*/
	public static void download(HttpServletRequest request, HttpServletResponse response, File file)throws ServletException, IOException {
		String mimetype = request.getSession().getServletContext().getMimeType(file.getName());
		if (file == null || !file.exists() || file.length() <= 0 || file.isDirectory()) {
			throw new IOException("파일 객체가 Null 혹은 존재하지 않거나 길이가 0, 혹은 파일이 아닌 디렉토리.");
		}
 	    InputStream is = null;
 	    try {
 	    	is = new FileInputStream(file);
 	    	download(request, response, is, file.getName(), file.length(), mimetype);
 	    } finally {
 	    	try {
 	    		if(is != null) is.close();
 	    	} catch (IOException e) {
       			LOG.info("[download] 실패 : ");
 	    	}
 	    }
	}
	
	/**
	* 해당 입력 스트림으로부터 오는 데이터를 다운로드 한다.
	* 
	* @param request
	* @param response
	* @param is 입력 스트림
	* @param filename 파일 이름
	* @param filesize 파일 크기
	* @param mimetype MIME 타입 지정
	* @throws ServletException
	* @throws IOException
	*/
	public static void download(HttpServletRequest request, HttpServletResponse response, InputStream is, String filename, long filesize, String mimetype) throws ServletException, IOException {
		String mime = mimetype;
		if (mimetype == null || mimetype.length() == 0) {
			mime = "application/octet-stream;";
		}
		
		//filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		byte[] buffer = new byte[BUFFER_SIZE];

		response.setContentType(mime + "; charset=" + CHARSET);		

		// 아래 부분에서 euc-kr 을 utf-8 로 바꾸거나 URLEncoding을 안하거나 등의 테스트를
		// 해서 한글이 정상적으로 다운로드 되는 것으로 지정한다.
		String userAgent = request.getHeader("User-Agent");
		
		// attachment; 가 붙으면 IE의 경우 무조건 다운로드창이 뜬다. 상황에 따라 써야한다.
		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
			response.setHeader("Content-Disposition", "filename=" + filename + ";");
		} else if (userAgent != null && userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
			response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		} else if (userAgent != null && userAgent.indexOf("Trident") > -1) { // MS IE11 
			response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		}else if (userAgent != null && userAgent.indexOf("Chrome") > -1) { // MS IE (보통은 6.x 이상 가정)
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(filename, "UTF-8") + ";");
			response.setHeader("Content-Transfer-Encoding", "binary");
		} else { // 모질라나 오페라
			response.setHeader("Content-Disposition", "attachment; filename=" + new String(filename.getBytes(CHARSET), "latin1") + ";");
		}

		// 파일 사이즈가 정확하지 않을때는 아예 지정하지 않는다.
		if (filesize > 0) {
			response.setHeader("Content-Length", "" + filesize);
		}

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(is);
			outs = new BufferedOutputStream(response.getOutputStream());
			int read = 0;
			while ((read = fin.read(buffer)) != -1) {
				outs.write(buffer, 0, read);
				outs.flush();
			}
		} catch (IOException ex) {
			LOG.info("[download] 실패0 : ");
		} finally {
			try {
				if(outs != null) outs.close();
			} catch (IOException ex1) {
				LOG.info("[download] 실패1 : ");
			}
			try {
				if(fin != null) fin.close();
			} catch (IOException ex2) {
				LOG.info("[download] 실패2 : ");
			}
		} // end of try/catch
	}
}


