package xyz.itwill.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

/*

이름            널?       유형            
------------- -------- ------------- 
IDX      		NOT NULL NUMBER        
ID                		 VARCHAR2(13)  
PASSWORD          		 VARCHAR2(100) 
NAME     		NOT NULL VARCHAR2(50)  
PHONE             		 VARCHAR2(50)  
EMAIL             		 VARCHAR2(50)  
GENDER            		 CHAR(6)       
BIRTH             		 DATE          
ADDRESS1          		 VARCHAR2(10)  
ADDRESS2          		 VARCHAR2(10)  
ADDRESS3          		 VARCHAR2(10)  
STATUS            		 NUMBER(1)     
SUB_DAY               	 TIMESTAMP(6)  

*/

@Data
public class Account {
	private int idx;
	private String id;
	private String password;
	private String name;
	private String phone;
	private String email;
	private int gender;
	private String birth;
	private String address1;
	private String address2;
	private String address3;
	private int status;
	private String subDay;

	// 비밀번호 변경을 위한 필드 추가
	@NotEmpty(message = "현재 비밀번호를 반드시 입력해주세요.")
	@Size(min = 6, max = 6, message = "발급받은 임시비밀번호를 입력해주세요.")
	@Pattern(regexp = "^(?=.*[0-9a-zA-Z@#$%^&+=!]).{6,}$")
	private String currentPassword;

	@NotEmpty(message = "새 비밀번호를 반드시 입력해주세요.")
	@Size(min = 8, max = 12, message = "비밀번호는 8자~12자 사이여야 합니다.")
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,12}$", message = "새로운 비밀번호는 영어 대소문자, 숫자, 특수문자가 꼭 포함되어야 합니다.")
	private String newPassword;

	@NotEmpty(message = "새 비밀번호 확인을 반드시 입력해주세요.")
	private String confirmPassword;
}