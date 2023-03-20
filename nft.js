// Importer la bibliothèque Web3.js
const Web3 = require("web3")

// Configurer Web3 avec l'adresse IP et le port de Ganache
const web3 = new Web3("http://127.0.0.1:7545")

// Charger l'ABI et l'adresse du smart contract
const contractABI = require("./build/contracts/ConcertNFT.json").abi
const contractAddress = "0x9768E2d9C4a3F08ae357BEDB27009C9E8b371A8B" // adresse du contrat déployé

// Créer une instance du contrat
const contractInstance = new web3.eth.Contract(contractABI, contractAddress)

// Fonction pour créer un NFT
async function createNFT(artist, location, date, price) {
	const accounts = await web3.eth.getAccounts()
	const result = await contractInstance.methods.createConcert(artist, location, date, price).send({ from: accounts[0], gas: 3000000 })
	console.log(`NFT créé avec succès : ${result.transactionHash}`)
}

// Fonction pour récupérer la liste des concerts
async function getConcerts() {
	const totalConcerts = await contractInstance.methods.totalConcerts().call()
	const concerts = []
	for (let i = 0; i < totalConcerts; i++) {
		const concert = await contractInstance.methods.concerts(i).call()
		concerts.push(concert)
	}
    console.log(concerts)
    return concerts
}


// // Fonction pour acheter un NFT
// async function buyNFT(tokenId) {
// 	const accounts = await web3.eth.getAccounts()
// 	const price = await contractInstance.methods.concerts(tokenId).price().call()
// 	const result = await contractInstance.methods.buyConcert(tokenId).send({ from: accounts[0], value: price, gas: 3000000 })
// 	console.log(`NFT acheté avec succès : ${result.transactionHash}`)
// }


// Exemple d'utilisation : créer un NFT et l'acheter
// createNFT("Ruben Chetboun", "Orange Vélodrome", 1649452800, web3.utils.toWei("1", "ether"))
getConcerts()

