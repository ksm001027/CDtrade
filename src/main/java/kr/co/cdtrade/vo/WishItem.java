// vo/WishItem.java
package kr.co.cdtrade.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("WishItem")
public class WishItem {
    private int no;
    private User user;
    private Album album;
    private Date createdAt;
    private Date updatedAt;
}