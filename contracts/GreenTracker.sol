// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

struct FollowerInfo {
    bool follower;
    uint256 index;
}

struct FollowingInfo {
    bool following;
    uint256 index;
}

struct User {
    string name;
    string description;
    string image_url;
}

contract GreenTracker {
    //Create following mapping
    mapping(address => address[]) public following;
    //Create followers mapping
    mapping(address => address[]) public followers;
    //isFollowing index mapping to bool
    mapping(address => mapping(address => FollowingInfo))
        public isFollowingIndex;
    //isFollower index mapping to bool
    mapping(address => mapping(address => FollowingInfo))
        public isFollowerIndex;

    mapping(address => User) public users;

    function isFollowing(address _followed) public view returns (bool) {
        return isFollowingIndex[msg.sender][_followed].following;
    }

    function follow(address _followed) public {
        require(_followed != msg.sender, "You can't follow yourself");
        require(
            !isFollowing(_followed),
            "You are already following this address"
        );

        following[msg.sender].push(_followed);
        isFollowingIndex[msg.sender][_followed] = FollowingInfo(
            true,
            following[msg.sender].length - 1
        );
        followers[_followed].push(msg.sender);
        isFollowerIndex[_followed][msg.sender] = FollowingInfo(
            true,
            followers[_followed].length - 1
        );
    }

    function getFollowers(
        address _address,
        uint256 _indexStart,
        uint256 _indexEnd
    ) public view returns (address[] memory) {
        // returns followers between index

        // Check if the array has enough elements between indexStart and indexEnd

        require(
            _indexEnd <= followers[_address].length,
            "The array doesn't have enough elements"
        );

        address[] memory _followers = new address[](_indexEnd - _indexStart);
        for (uint256 i = _indexStart; i < _indexEnd; i++) {
            _followers[i] = followers[_address][i];
        }
        return _followers;
    }

    function getFollowing(
        address _address,
        uint256 _indexStart,
        uint256 _indexEnd
    ) public view returns (address[] memory) {
        // returns following between index

        require(
            _indexEnd <= following[_address].length,
            "The array doesn't have enough elements"
        );

        address[] memory _following = new address[](_indexEnd - _indexStart);
        for (uint256 i = _indexStart; i < _indexEnd; i++) {
            _following[i] = following[_address][i];
        }
        return _following;
    }

    function createUser(
        string memory _name,
        string memory _description,
        string memory _image_url
    ) public {
        users[msg.sender] = User(_name, _description, _image_url);
    }

    function getFollowersCount(address _address) public view returns (uint256) {
        return followers[_address].length;
    }

    function getFollowingCount(address _address) public view returns (uint256) {
        return following[_address].length;
    }

    function unfollow(address _followed) public {
        require(isFollowing(_followed), "You are not following this address");
        // Get the index of the followed address in the following array
        uint256 followingIndex = isFollowingIndex[msg.sender][_followed].index;
        // Get the index of the follower address in the followers array
        uint256 followerIndex = isFollowerIndex[_followed][msg.sender].index;
        // Get the address of the last element in the following array
        address lastFollowing = following[msg.sender][
            following[msg.sender].length - 1
        ];
        // Get the address of the last element in the followers array
        address lastFollower = followers[_followed][
            followers[_followed].length - 1
        ];
        // Replace the address to unfollow with the last address in the following array
        following[msg.sender][followingIndex] = lastFollowing;
        // Replace the address to unfollow with the last address in the followers array
        followers[_followed][followerIndex] = lastFollower;
        // Update the index of the address to unfollow in the following array
        isFollowingIndex[msg.sender][lastFollowing].index = followingIndex;
        // Update the index of the address to unfollow in the followers array
        isFollowerIndex[_followed][lastFollower].index = followerIndex;
        // Delete the last element of the following array
        following[msg.sender].pop();
        // Update the isFollowing mapping to show false
        isFollowingIndex[msg.sender][_followed].following = false;
        // Update the isFollower mapping to show false
        isFollowerIndex[_followed][msg.sender].following = false;
    }
}
