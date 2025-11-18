// scripts/deployAuction.js

/**
 * Hardhat deployment script for RealWorldAssetAuction.sol
 * * Usage: npx hardhat run scripts/deployAuction.js --network <network-name>
 */

const { ethers } = require("hardhat");

async function main() {
    // 1. Get the Signer (Deployer)
    const [deployer] = await ethers.getSigners();
    const deployerAddress = deployer.address;

    console.log("-------------------------------------------------------");
    console.log("🔨 Deploying RealWorldAssetAuction contract...");
    console.log(`👤 Deploying with account: ${deployerAddress}`);
    
    // 2. Deploy the Contract
    // Get the contract factory for the compiled contract
    const AuctionFactory = await ethers.getContractFactory("RealWorldAssetAuction");
    
    // Deploy the contract. Since the constructor takes no arguments, we call deploy() with no args.
    const auctionContract = await AuctionFactory.deploy();

    // Wait for the deployment transaction to be mined
    await auctionContract.waitForDeployment();
    
    const contractAddress = await auctionContract.getAddress();
    
    console.log(`\n✅ RealWorldAssetAuction deployed to: ${contractAddress}`);
    console.log("-------------------------------------------------------");

    // Optional: Example of how to interact with the contract after deployment
    /*
    // --- Post-Deployment Interaction Example ---
    const ONE_DAY_IN_SECONDS = 86400; // 24 * 60 * 60
    const minBid = ethers.parseEther("1"); // 1 ETH minimum bid

    console.log("\n🧪 Creating a test auction...");
    
    // Create an auction for "Property #456" with 1-day duration and 1 ETH min bid
    const createTx = await auctionContract.createAuction(
        "Property #456", 
        456, // Asset ID
        minBid, 
        ONE_DAY_IN_SECONDS
    );
    await createTx.wait();
    console.log("Auction 1 created successfully.");
    
    // Fetch and log the new auction details
    const auctionDetails = await auctionContract.getAuction(1);
    console.log(`Auction 1 Details: Asset=${auctionDetails.assetName}, Min Bid=${ethers.formatEther(auctionDetails.minBid)} ETH`);
    */
}

// Standard Hardhat error handling
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
