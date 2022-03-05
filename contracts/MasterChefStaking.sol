// SPDX-License-Identifier: UNLICENSED

/**
 *Submitted for verification at BscScan.com on 2022-02-17
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address _owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT:  Beware that changingan allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

pragma solidity ^0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

pragma solidity ^0.8.0;

library SafeBEP20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IBEP20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IBEP20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IBEP20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IBEP20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeBEP20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IBEP20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IBEP20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeBEP20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IBEP20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeBEP20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeBEP20: BEP20 operation did not succeed");
        }
    }
}

pragma solidity ^0.8.0;

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

pragma solidity ^0.8.0;

contract MasterChef is Ownable {
    using SafeMath for uint256;
    using SafeBEP20 for IBEP20;

    // Info of each user.
    struct UserInfo {
        uint256 amount;
        uint256 rewardDebt;
        uint256 pendingAmount;
        uint256 lastStakedTime;
    }

    struct UnStakeFee {
        uint256 minDays;
        uint256 feePercent;
    }

    UnStakeFee[] public unStakeFees;

    IBEP20 public immutable cspdToken;
    uint256 public lastRewardBlock;
    uint256 public accCSPDPerShare;
    uint256 public rewardPerBlock;
    address public feeWallet;
    uint256 public harvestFee;

    uint256 public totalStakedAmount;

    uint256 private _rewardBalance;


    // Info of each user that stakes LP tokens.
    mapping (address => UserInfo) public userInfo;

    event Stake(address indexed user, uint256 amount);
    event ReStake(address indexed user, uint256 amount);
    event DepositReward(address indexed user, uint256 amount);
    event UnStake(address indexed user, uint256 amount, uint256 unStakeFee);
    event Harvest(address indexed user, uint256 amount, uint256 harvestFee);
    event SetFeeWallet(address indexed _feeWallet);
    event SetUnStakeFee(uint256 _index, uint256 _minDays, uint256 _feePercent);
    event AddUnStakeFee(uint256 _index, uint256 _minDays, uint256 _feePercent);
    event RemoveUnStakeFee(uint256 _index, uint256 _minDays, uint256 _feePercent);
    event SetHarvestFee(uint256 _harvestFee);

    constructor(
        IBEP20 _cspdToken,
        uint256 _rewardPerBlock,
        address _feeWallet
    ) {
        cspdToken = _cspdToken;
        rewardPerBlock = _rewardPerBlock;
        feeWallet = _feeWallet;
        init();
    }

    function init() private {
        UnStakeFee memory unStakeFee1 = UnStakeFee({
            minDays: 7,
            feePercent: 40
        });
        unStakeFees.push(unStakeFee1);

        UnStakeFee memory unStakeFee2 = UnStakeFee({
            minDays: 14,
            feePercent: 30
        });
        unStakeFees.push(unStakeFee2);

        UnStakeFee memory unStakeFee3 = UnStakeFee({
            minDays: 21,
            feePercent: 20
        });
        unStakeFees.push(unStakeFee3);

        UnStakeFee memory unStakeFee4 = UnStakeFee({
            minDays: 30,
            feePercent: 10
        });
        unStakeFees.push(unStakeFee4);
    }

    function setFeeWallet(address _feeWallet) external onlyOwner {
        feeWallet = _feeWallet;
        emit SetFeeWallet(feeWallet);
    }

    function setUnStakeFee(uint256 _index, uint256 _minDays, uint256 _feePercent) external onlyOwner {
        require(_index < unStakeFees.length, "setUnStakeFee: range out");
        require(_minDays > 0, "setUnStakeFee: minDays is 0");
        require(_feePercent <= 40, "setUnStakeFee: feePercent > 40");
        if (_index == 0) {
            require(_minDays < unStakeFees[1].minDays, "setUnStakeFee: minDays is error");
            require(_feePercent > unStakeFees[1].feePercent, "setUnStakeFee: feePercent is error");
        } else if (_index == unStakeFees.length - 1) {
            require(_minDays > unStakeFees[_index - 1].minDays, "setUnStakeFee: minDays is error");
            require(_feePercent < unStakeFees[_index - 1].feePercent, "setUnStakeFee: feePercent is error");
        } else {
            require(_minDays > unStakeFees[_index - 1].minDays && _minDays < unStakeFees[_index + 1].minDays, "setUnStakeFee: minDays is error");
            require(_feePercent < unStakeFees[_index - 1].feePercent && _feePercent > unStakeFees[_index + 1].feePercent, "setUnStakeFee: feePercent is error");
        }
        unStakeFees[_index].feePercent = _feePercent;
        unStakeFees[_index].minDays = _minDays;
        emit SetUnStakeFee(_index, _minDays, _feePercent);
    }

    function addUnStakeFee(uint256 _minDays, uint256 _feePercent) external onlyOwner {
        require(_minDays > 0, "addUnStakeFee: minDays is 0");
        require(_feePercent <= 40, "addUnStakeFee: feePercent > 40");
        require(_minDays > unStakeFees[unStakeFees.length - 1].minDays, "addUnStakeFee: minDays is error");
        require(_feePercent < unStakeFees[unStakeFees.length - 1].feePercent, "addUnStakeFee: feePercent is error");
        UnStakeFee memory unStakeFee = UnStakeFee({
            minDays: _minDays,
            feePercent: _feePercent
        });
        unStakeFees.push(unStakeFee);
        emit AddUnStakeFee(unStakeFees.length, _minDays, _feePercent);
    }

    function removeUnStakeFee(uint256 _index) external onlyOwner {
        require(_index < unStakeFees.length, "removeUnStakeFee: range out");
        uint256 _minDays = unStakeFees[_index].minDays;
        uint256 _feePercent = unStakeFees[_index].feePercent;
        for (uint256 i = _index; i < unStakeFees.length - 1; i++) {
            unStakeFees[i] = unStakeFees[i+1];
        }
        unStakeFees.pop();
        emit RemoveUnStakeFee(_index, _minDays, _feePercent);
    }

    function setHarvestFee(uint256 _feePercent) external onlyOwner {
        require(_feePercent <= 40, "setHarvestFee: feePercent > 40");
        harvestFee = _feePercent;
        emit SetHarvestFee(_feePercent);
    }

    function getMultiplier(uint256 _from, uint256 _to) public pure returns (uint256) {
        return _to.sub(_from);
    }

    function getPending(address _user) public view returns (uint256) {
        uint256 pending = _getPending(_user);
        uint256 _harvestFee = pending.mul(harvestFee).div(100);
        return pending - _harvestFee;
    }

    function _getPending(address _user) private view returns (uint256) {
        UserInfo storage user = userInfo[_user];
        uint256 acc = accCSPDPerShare;
        if (block.number > lastRewardBlock && totalStakedAmount != 0 && _rewardBalance > 0) {
            uint256 multiplier = getMultiplier(lastRewardBlock, block.number);
            uint256 reward = multiplier.mul(rewardPerBlock);
            if (_rewardBalance < reward) {
                acc = acc.add(_rewardBalance.mul(1e12).div(totalStakedAmount));
            }
            acc = acc.add(reward.mul(1e12).div(totalStakedAmount));
        }
        return user.amount.mul(acc).div(1e12).sub(user.rewardDebt).add(user.pendingAmount);
    }

    function getRewardBalance() external view returns (uint256) {
        if (block.number > lastRewardBlock && totalStakedAmount != 0) {
            uint256 multiplier = getMultiplier(lastRewardBlock, block.number);
            uint256 reward = multiplier.mul(rewardPerBlock);
            return _rewardBalance.sub(reward);
        }
        else {
            return _rewardBalance;
        }
    }

    function depositReward(uint256 _amount) external onlyOwner {
        cspdToken.safeTransferFrom(msg.sender, address(this), _amount);
        emit DepositReward(msg.sender, _amount);
        _rewardBalance = _rewardBalance.add(_amount);
    }

    function updateStatus() private {
        if (block.number <= lastRewardBlock) {
            return;
        }
        if (totalStakedAmount == 0) {
            lastRewardBlock = block.number;
            return;
        }
        uint256 multiplier = getMultiplier(lastRewardBlock, block.number);
        uint256 reward = multiplier.mul(rewardPerBlock);
        if (_rewardBalance == 0) {
            lastRewardBlock = block.number;
            return;
        }
        if (_rewardBalance < reward) {
            accCSPDPerShare = accCSPDPerShare.add(_rewardBalance.mul(1e12).div(totalStakedAmount));
            _rewardBalance = 0;
        } else {
            _rewardBalance = _rewardBalance.sub(reward);
            accCSPDPerShare = accCSPDPerShare.add(reward.mul(1e12).div(totalStakedAmount));
        }
        lastRewardBlock = block.number;
    }

    function stake(uint256 _amount) public {
        require(_rewardBalance > 0, "rewardBalance is 0");
        UserInfo storage user = userInfo[msg.sender];
        updateStatus();
        if (user.amount > 0) {
            uint256 pending = user.amount.mul(accCSPDPerShare).div(1e12).sub(user.rewardDebt);
            user.pendingAmount = user.pendingAmount.add(pending);
        }
        cspdToken.safeTransferFrom(msg.sender, address(this), _amount);
        totalStakedAmount = totalStakedAmount.add(_amount);
        user.amount = user.amount.add(_amount);
        user.rewardDebt = user.amount.mul(accCSPDPerShare).div(1e12);
        user.lastStakedTime = block.timestamp;
        emit Stake(msg.sender, _amount);
    }

    function unStake(uint256 _amount) public {
        UserInfo storage user = userInfo[msg.sender];
        require(user.amount >= _amount, "unStake: not good");
        updateStatus();
        uint256 pending = user.amount.mul(accCSPDPerShare).div(1e12).sub(user.rewardDebt);
        if (cspdToken.balanceOf(address(this)) < pending) {
            pending = cspdToken.balanceOf(address(this));
        }
        user.pendingAmount = user.pendingAmount.add(pending);
        user.amount = user.amount.sub(_amount);
        user.rewardDebt = user.amount.mul(accCSPDPerShare).div(1e12);
        uint256 feePercent = getUnStakeFeePercent(msg.sender);
        uint256 unStakeFee = _amount.mul(feePercent).div(100);
        uint256 amount = _amount.sub(unStakeFee);
        cspdToken.safeTransfer(msg.sender, amount);
        cspdToken.safeTransfer(feeWallet, unStakeFee);
        totalStakedAmount = totalStakedAmount.sub(_amount);
        emit UnStake(msg.sender, amount, unStakeFee);
    }

    function getUnStakeFeePercent(address _user) public view returns (uint256) {
        UserInfo storage user = userInfo[_user];
        for (uint256 i = 0; i < unStakeFees.length; i++) {
            if (unStakeFees[i].minDays.mul(3600 * 24) >= (block.timestamp - user.lastStakedTime)) {
                return unStakeFees[i].feePercent;
            }
        }
        return 0;
    }

    function harvest(bool reStake) public {
        uint256 rewardAmount = _getPending(msg.sender);
        
        if (reStake) {
            require(_rewardBalance > 0, "rewardBalance is 0");
            UserInfo storage user = userInfo[msg.sender];
            totalStakedAmount = totalStakedAmount.sub(user.amount);
            updateStatus();
            user.pendingAmount = 0;
            user.amount = user.amount.add(rewardAmount);
            totalStakedAmount = totalStakedAmount.add(user.amount);
            user.rewardDebt = user.amount.mul(accCSPDPerShare).div(1e12);
            emit ReStake(msg.sender, rewardAmount);
        } else {
            UserInfo storage user = userInfo[msg.sender];
            uint256 _harvestFee = rewardAmount.mul(harvestFee).div(100);
            uint256 amount = rewardAmount - _harvestFee;
            if (cspdToken.balanceOf(address(this)) < amount) {
                amount = cspdToken.balanceOf(address(this));
            }

            cspdToken.safeTransfer(msg.sender, amount);

            if (cspdToken.balanceOf(address(this)) < _harvestFee) {
                _harvestFee = cspdToken.balanceOf(address(this));
            }


            cspdToken.safeTransfer(feeWallet, _harvestFee);
            emit Harvest(msg.sender, amount, _harvestFee);

            updateStatus();
            user.pendingAmount = 0;
            user.rewardDebt = user.amount.mul(accCSPDPerShare).div(1e12);
        }
    }
}
