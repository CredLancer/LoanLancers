// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleCredentialsVerifier {
    struct FreelancingContract {
        address client;
        address freelancer;
        uint256 amount;
         uint64[] skillBadges;
        bool isCompleted;
    }

    mapping(address => FreelancingContract[]) public freelancerToContracts;
    mapping(address => uint64[]) public walletToSkillBadges;

    function hasOpenContracts(address freelancer, uint256 minAmount)
        public
        view
        returns (bool)
    {
        FreelancingContract[] memory contracts = freelancerToContracts[
            freelancer
        ];
        for (uint256 i = 0; i < contracts.length; i++) {
            if (!contracts[i].isCompleted && contracts[i].amount >= minAmount) {
                return true;
            }
        }
        return false;
    }

    function hasRequiredSkills(address freelancer) public view returns (bool) {
        uint64[] memory badges = walletToSkillBadges[freelancer];
        FreelancingContract[] memory contracts = freelancerToContracts[freelancer];
        
        for (uint256 i = 0; i < contracts.length; i++) {
            if (!contracts[i].isCompleted) {
                bool hasAllBadges = true;
                for (uint256 j = 0; j < contracts[i].skillBadges.length; j++) {
                    bool hasBadge = false;
                    for (uint256 k = 0; k < badges.length; k++) {
                        if (badges[k] == contracts[i].skillBadges[j]) {
                            hasBadge = true;
                            break;
                        }
                    }
                    if (!hasBadge) {
                        hasAllBadges = false;
                        break;
                    }
                }
                if (hasAllBadges) {
                    return true; // Freelancer has all required badges for at least one contract
                }
            }
        }
    
    return false; // Freelancer does not have all required badges for any contract
}

    function isEnabledToBorrow(
        address freelancer,
        uint256 minAmount
    ) public view returns (bool) {
        return
            hasOpenContracts(freelancer, minAmount) &&
            hasRequiredSkills(freelancer);
    }
}
