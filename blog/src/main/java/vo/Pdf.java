package vo;

public class Pdf {
	private int pdfNo;
	private String pdfName;
	private String pdfOriginalName;
	private String pdfType; 
	private String pdfPw;
	private String writer; 
	private String createDate;
	private String updateDate;
	
	public Pdf() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Pdf(int pdfNo, String pdfName, String pdfOriginalName, String pdfType, String pdfPw, String writer,
			String createDate, String updateDate) {
		super();
		this.pdfNo = pdfNo;
		this.pdfName = pdfName;
		this.pdfOriginalName = pdfOriginalName;
		this.pdfType = pdfType;
		this.pdfPw = pdfPw;
		this.writer = writer;
		this.createDate = createDate;
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "Pdf [pdfNo=" + pdfNo + ", pdfName=" + pdfName + ", pdfOriginalName=" + pdfOriginalName + ", pdfType="
				+ pdfType + ", pdfPw=" + pdfPw + ", writer=" + writer + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}

	public int getPdfNo() {
		return pdfNo;
	}

	public void setPdfNo(int pdfNo) {
		this.pdfNo = pdfNo;
	}

	public String getPdfName() {
		return pdfName;
	}

	public void setPdfName(String pdfName) {
		this.pdfName = pdfName;
	}

	public String getPdfOriginalName() {
		return pdfOriginalName;
	}

	public void setPdfOriginalName(String pdfOriginalName) {
		this.pdfOriginalName = pdfOriginalName;
	}

	public String getPdfType() {
		return pdfType;
	}

	public void setPdfType(String pdfType) {
		this.pdfType = pdfType;
	}

	public String getPdfPw() {
		return pdfPw;
	}

	public void setPdfPw(String pdfPw) {
		this.pdfPw = pdfPw;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	} 
	
	
}
