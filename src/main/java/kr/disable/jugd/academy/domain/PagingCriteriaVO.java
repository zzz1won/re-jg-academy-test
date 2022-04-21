package kr.disable.jugd.academy.domain;


public class PagingCriteriaVO {
//220421. 검색기능 중 검색기록을 화면에 남기려고 생성하는 VO
    // pagination 이라는 파일을 찾았다 이건 사용하지않음!
    /*private int pageNum; //페이지 번호
    private int amount; //페이지당 데이터 갯수
    private String type; //타입
    private String keyword; //검색어

    public PagingCriteriaVO() {
        this(1,10);
    }

    public PagingCriteriaVO(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public int getPageNum() {        return pageNum;    }
    public void setPageNum(int pageNum) {        this.pageNum = pageNum;    }

    public int getAmount() {        return amount;    }
    public void setAmount(int amount) {        this.amount = amount;    }

    public String getType() {        return type;    }
    public void setType(String type) {        this.type = type;    }

    public String getKeyword() {        return keyword;    }
    public void setKeyword(String keyword) {        this.keyword = keyword;    }

    //추가 //왜 하는건지
    public String[] getTypeArr(){
        return type == null? new String[] {}: type.split("");
    }
    //type이 null일 때, 한 글자씩 나눠서 배열로 만드는 코드
    // HI 일 때 "H" / "I" 나눠서 배열로 만든다고...*/
}
