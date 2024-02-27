package com.bitc.aop;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.mapper.MessageMapper;
import com.bitc.vo.MessageVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
 		locations= {"classpath:/context/root-context.xml"}
)
public class MessageMapperTest {

	@Autowired
	MessageMapper mapper;
	
	// @Test
	public void testMapper() throws Exception{
		MessageVO vo = new MessageVO();
		vo.setTargetid("test");
		vo.setSender("test");
		vo.setMessage("되나");
		mapper.create(vo);
	}
	
	@Test
	public void test1update() throws Exception{
		mapper.updatemessage(1);
	}
	
	@Test
	public void testList() throws Exception{
		List<MessageVO> list = mapper.list();
		System.out.println(list);
		
		MessageVO read = mapper.readMessage(1);
		System.out.println(read);
	}
}
