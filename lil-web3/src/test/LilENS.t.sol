// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.10;

import { Vm } from 'forge-std/Vm.sol';
import { LilENS } from '../LilENS.sol';
import { DSTest } from 'ds-test/test.sol';

contract User {}

contract LilENSTest is DSTest {
	User internal user;
	LilENS internal lilENS;
	Vm internal hevm = Vm(HEVM_ADDRESS);

	function setUp() public {
		user = new User();
		lilENS = new LilENS();
	}

	function testCanRegister() public {
		assertEq(lilENS.lookup('test'), address(0));

		lilENS.register('test');

		assertEq(lilENS.lookup('test'), address(this));
	}

	function testCannotRegisterExistingName() public {
		lilENS.register('test');
		assertEq(lilENS.lookup('test'), address(this));

		hevm.prank(address(user));
		hevm.expectRevert(abi.encodeWithSignature('AlreadyRegistered()'));
		lilENS.register('test');

		assertEq(lilENS.lookup('test'), address(this));
	}

	function testCanUpdate() public {
		lilENS.register('test');
		assertEq(lilENS.lookup('test'), address(this));

		lilENS.update('test', address(user));
		assertEq(lilENS.lookup('test'), address(user));
	}

	function testNonOwnerCannotUpdate() public {
		lilENS.register('test');
		assertEq(lilENS.lookup('test'), address(this));

		hevm.prank(address(user));
		hevm.expectRevert(abi.encodeWithSignature('Unauthorized()'));
		lilENS.update('test', address(user));

		assertEq(lilENS.lookup('test'), address(this));
	}
}
