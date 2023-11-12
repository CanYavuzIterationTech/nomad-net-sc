import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox-viem/network-helpers";
import { expect } from "chai";
import hre from "hardhat";
import { getAddress, parseGwei } from "viem";

describe("GreenTracker", function () {
  describe("Deployment", function () {
    it("Should be able to deployed", async function () {
      const [owner, acc1, acc2, acc3] = await hre.viem.getWalletClients();

      const greenTracker = await hre.viem.deployContract(
        "GreenTracker",
        [],
        {}
      );
    });
  });

  describe("CreateUser", function () {
    it("Should be able to create user", async function () {
      const [owner, acc1, acc2, acc3] = await hre.viem.getWalletClients();

      const greenTracker = await hre.viem.deployContract(
        "GreenTracker",
        [],
        {}
      );

      const user = await greenTracker.write.createUser([
        "test",
        "test",
        "test",
      ]);

      const follow = await greenTracker.write.follow([acc1.account.address]);

      const res = await greenTracker.read.getFollowersCount([
        acc1.account.address,
      ]);
      const res2 = await greenTracker.read.getFollowers([
        acc1.account.address,
        0n,
        1n,
      ]);
      const res3 = await greenTracker.read.getFollowing([
        owner.account.address,
        0n,
        1n,
      ]);
      const userInfo = await greenTracker.read.users([owner.account.address]);
      console.log(res);
      console.log(res2);
      console.log(res3);
      console.log(userInfo);
      expect(user).to.be.ok;
      expect(follow).to.be.ok;
    });
  });
});
