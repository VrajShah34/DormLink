// controllers/sportController.js

const Sport = require('../models/Sports');

// Add a new sport
exports.addSport = async (req, res) => {
  try {
    const { sportname, numberOfPlayers } = req.body;
    const sport = new Sport({ sportname, numberOfPlayers, players: [] });
    await sport.save();
    res.status(201).json(sport);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server Error');
  }
};

// Add a player to a sport
exports.addPlayerToSport = async (req, res) => {
    try {
      const sportname=req.params.sportname;
      const { enrollmentNo, name} = req.body;
      const startTime = new Date();
  
      // Check if the player is already playing a sport
      const existingSport = await Sport.findOne({ 'players.enrollmentNo': enrollmentNo });
      if (existingSport) {
        return res.status(400).send('Player is already playing another sport');
      }
  
      const sport = await Sport.findOne({ sportname: sportname });
      if (!sport) {
        return res.status(404).send('Sport not found');
      }
      if (sport.players.length >= sport.numberOfPlayers) {
        return res.status(400).send('No available slots for this sport');
      }
      sport.players.push({ enrollmentNo, name , startTime});
      await sport.save();
      res.status(201).json(sport);
    } catch (error) {
      console.error(error);
      res.status(500).send('Server Error');
    }
  };

// Get all players currently playing for a specific sport
exports.getPlayersInSport = async (req, res) => {
  try {
    const sportname=req.params.sportname;
    const sport = await Sport.findOne({ sportname: sportname });
    if (!sport) {
      return res.status(404).send('Sport not found');
    }
    const players = sport.players;
    res.json(players);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server Error');
  }
};

// Remove oneself from a sport
exports.removePlayerFromSport = async (req, res) => {
    try {
      const sportname=req.params.sportname;
      const { enrollmentNo, name} = req.body;
      const sport = await Sport.findOne({ sportname: sportname });
      if (!sport) {
        return res.status(404).send('Sport not found');
      }
      const playerIndex = sport.players.findIndex(player => player.enrollmentNo === enrollmentNo);
      if (playerIndex === -1) {
        return res.status(404).send('Player not found in this sport');
      }
      sport.players.splice(playerIndex, 1);
      await sport.save();
      res.status(200).json(sport);
    } catch (error) {
      console.error(error);
      res.status(500).send('Server Error');
    }
  };
