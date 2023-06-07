package com.kh.idolsns.restcontroller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.idolsns.dto.CalendarDto;
import com.kh.idolsns.repo.CalendarRepo;

@RestController
@RequestMapping("/calendar")
public class CalendarRestController {

	@Autowired
	private CalendarRepo calendarRepo;
	
	@PostMapping("/add")
	public void insertCalendar(@RequestBody CalendarDto dto) {
		dto.setCalendarNo(calendarRepo.sequence());
		calendarRepo.insert(dto);
	}
	
	@GetMapping("/load/{memberId}")
	public List<CalendarDto> calendarList(@PathVariable String memberId) {
		return calendarRepo.selectList(memberId);
	}
	
	@GetMapping("/detail/{calendarNo}")
	public CalendarDto calendarOne(@PathVariable int calendarNo) {
		return calendarRepo.selectOne(calendarNo);
	}
	
	@DeleteMapping("/{calendarNo}")
	public void deleteCalendar(@PathVariable int calendarNo) {
		calendarRepo.delete(calendarNo);
	}
	
	@PutMapping("/date")
	public void updateDate(@RequestBody CalendarDto dto) {
		calendarRepo.updateDate(dto);
	}
	
	@PutMapping("/content")
	public void updateContent(@RequestBody CalendarDto dto) {
		calendarRepo.updateContent(dto);
	}
	
}
