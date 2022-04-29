package vo;
// category 테이블 VO(도메인객체) : VO, DTO, Domain
public class Category {
	private String categoryName;
	private String createDate;
	private String updateDate;
	
	public Category() {}

	public Category(String categoryName, String createDate, String updateDate) {
		super();
		this.categoryName = categoryName;
		this.createDate = createDate;
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "Category [categoryName=" + categoryName + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ "]";
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
