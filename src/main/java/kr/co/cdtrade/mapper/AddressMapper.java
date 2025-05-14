package kr.co.cdtrade.mapper;

import java.util.List;

import kr.co.cdtrade.vo.Address;

public interface AddressMapper {

	Address getBasicAddressByUserNo(int userNo);

	List<Address> getAllAddressByUserNo(int userNo);

	void insertAddress(Address address);

	void deleteAddress(int addrNo);

	void updateAllAddressToNonDefault(int userNo);

	void updateAddress(Address address);
}
