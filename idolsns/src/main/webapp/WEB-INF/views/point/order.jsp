<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 


  <style>
   @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}
		   	section {
			  font-family: "Noto Sans KR", sans-serif;
			}
			   	
		   
		    ul.point_header_tab {
		      padding: 0;
		      margin: 0;
		    }
		   
	    /* 탭 메뉴 스타일 */
	    .point_header_tab {
	        overflow: hidden;
			width:100%;
	
	    }
	
	    .tab_list {
	        background-color: inherit;
	        float: left;
	        border-bottom: 0.5px solid #f5f5f5;
	        outline: none;
	        cursor: pointer;
	        padding: 15px 15px;
	        transition: 0.3s;
	        font-size: 17px;
	        list-style: none; /* 불렛포인트 없애기 */
	        position: relative; /* 하위 요소에 적용할 수 있는 유사 클래스(자식 셀렉터)를 사용하기 위해 position을 추가 */
	        
	    }
	
	    .tab_list.active {
	       font-weight:bold;
	      	color: #77E9CC;
	        
	    }
	
	    .tab_list a {
	        text-decoration: none;
	        color: #333;
	        
	    }
	
	    .tab_list:hover {
	    
	    }
	
	    /* 하위 요소에 적용할 스타일 */
	    .tab_list.active::after {
	        content: '';
	        position: absolute;
	        bottom: 0;
	        left: 0;
	        width: 100%;
	        height: 4px;
	        background-color: #77E9CC;
	        
	    }
	    
	    .point_select {
	    	width: 100%;
	    
	    }
	    
	    .radio_label {
			white-space: nowrap;
		}
	   
	   
	   	.title {
	   		font-weight:bold;
	   	}
	   
	    
	</style>

     <div id="app">
      <div class="container rounded p-3" style="background-color:white">
        		 
        <ul class="point_header_tab">
            <li class="tab_list"><a href="charge">포인트 충전</a></li>
            <li class="tab_list"><a href="history">충전 내역</a></li>
            <li class="tab_list active"><a href="#">사용 내역</a></li>
        </ul>
	        
	        
	        
	        <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">사용 내역</h3>
	        
	        <div style="padding-left: 0.5em; padding-right: 0.5em;">
	            <p class="container rounded p-3 border">내 포인트: <span class="amount" style="color:#77E9CC; font-weight:bold" >{{ formattedAmount }}</span>원</p>
	        </div>
				
			<div class="modal-body" style="padding-left: 0.5em; padding-right: 0.5em;">
			  <table class="table">
			    <thead class="thead-light">
			      <tr>
			        <th>사용일</th>
			        <th>사용포인트</th>
			        <th>사용 내역</th>
			        <th>펀딩 상태</th>
			        <th>더보기</th>
			      </tr>
			    </thead>
				<tbody>
			   
			            <tr v-for="fundDto in paginatedItems">
			              <td>{{ fundDto.fundTime }}</td>
			              <td>{{ fundDto.fundPrice }}</td>
			              <td>{{ fundDto.fundTitle }}</td>
			              <td>{{ fundDto.fundStatus }}</td>
			              <td>
			                <a :href="'detailOrder?fundNo=' + fundDto.fundNo">
			                <button class="btn btn-sm btn-primary">
			               	더보기
			               	</button>
			                </a>
			              	
			              </td>
			            
			            </tr>
		
			        </tbody>
			  </table>
		  </div>
		  
		  <!-- 이전/다음 페이지로 이동하는 버튼 -->
    <div class="pagination justify-content-center mt-5">
      <ul class="pagination">
        <li class="page-item" :class="{ disabled: currentPage === 1 }">
          <a class="page-link" href="#" @click="previousPage">&lt;</a>
        </li>
        <li v-for="pageNumber in displayedPages" :key="pageNumber" class="page-item" :class="{ active: pageNumber === currentPage }">
          <a class="page-link" href="#" @click="goToPage(pageNumber)">{{ pageNumber }}</a>
        </li>
        <li class="page-item" :class="{ disabled: currentPage === totalPages }">
          <a class="page-link" href="#" @click="nextPage">&gt;</a>
        </li>
      </ul>
    </div>
		  
		  
		</div>
		</div>

<script>
   
	    Vue.createApp({
	        //데이터 설정 영역
	        data() {
	            return {
	               
	                amount: '',
	                selectedAmount: null,
	                memberId: '',
	                
	                <!--페이지네이션-->
		            itemsPerPage: 10,
		            currentPage: 1,
		            items: [], // 전체 항목 배열
	              
	            }
	        },
	        
	  
	        
	        computed: {
	     
	            formattedAmount() {
	                return this.amount.toLocaleString();
	            },
	            
                <!--페이지네이션-->
	            totalPages() {
	                return Math.ceil(this.items.length / this.itemsPerPage);
	              },
	              paginatedItems() {
	                const startIndex = (this.currentPage - 1) * this.itemsPerPage;
	                const endIndex = startIndex + this.itemsPerPage;
	                return this.items.slice(startIndex, endIndex);
	              },
	              displayedPages() {
	                const startPage = Math.max(1, this.currentPage - 2);
	                const endPage = Math.min(this.totalPages, startPage + 4);
	                return Array(endPage - startPage + 1)
	                  .fill()
	                  .map((_, index) => startPage + index);
	              },
	              showPreviousButton() {
	                return this.currentPage > 1;
	              },
	              showNextButton() {
	                return this.currentPage < this.totalPages;
	              },
	        },
	        methods: {
	   
				
	           	 async loadMemberPoint() {
	                     const url = "http://localhost:8080/rest/member/"+memberId;
	                     const data = {
	                         memberId: this.memberId // 로그인된 멤버 아이디 사용
	                     };
	                     const resp = await axios.get(url);

	                     this.amount = resp.data.memberPoint;
	            	// MemberRestController(rest/member)에 getMapping method 추가 후
	        		// Axios로 method 호출(await 사용, 전달 data-> 멤버아이디), 로 멤버DTO 정보 불러와서
	        		// 멤버 DTO의 point를 this.amount 대입
	        	},
	        	 async loadOrdertHistory() {
	                try {
	                  const url = "http://localhost:8080/rest/point/order/" + memberId;
	                  const response = await axios.get(url);
	                  this.items = response.data;
	                } catch (error) {
	                  console.error(error);
	                }
	              },
	              
	          
	              
	              <!--페이지네이션-->
	        	 previousPage() {
	        	      if (this.currentPage > 1) {
	        	        this.currentPage--;
	        	      }
	        	    },
	        	    nextPage() {
	        	      if (this.currentPage < this.totalPages) {
	        	        this.currentPage++;
	        	      }
	        	    },
	        	    goToPage(page) {
	        	      this.currentPage = page;
	        	    },
	            },
	            created() {
	              this.loadMemberPoint();
	              this.loadOrdertHistory();
	            }
	    }).mount("#app");

    </script>		
			





	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 