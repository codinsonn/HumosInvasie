-- phpMyAdmin SQL Dump
-- version 4.2.10
-- http://www.phpmyadmin.net
--
-- Host: 172.21.1.87
-- Generation Time: Jun 15, 2015 at 07:17 PM
-- Server version: 5.5.41-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `thorrsteveoshae7`
--

-- --------------------------------------------------------

--
-- Table structure for table `bdgt_admins`
--

CREATE TABLE IF NOT EXISTS `bdgt_admins` (
`id` smallint(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(24) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role_id` smallint(2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bdgt_admins`
--

INSERT INTO `bdgt_admins` (`id`, `email`, `username`, `password`, `role_id`) VALUES
(1, 'thor_r_stevens@hotmail.com', 'ThorrStevens', 'b3c1b1e6e9907bc0c05fb734afd20efc2a2e4480', 2),
(2, 'admin@humosinvasie.be', 'InvasieAdmin', '7fd859aa20de97218bf138f804ace0ab54488e31', 2);

-- --------------------------------------------------------

--
-- Table structure for table `bdgt_characters`
--

CREATE TABLE IF NOT EXISTS `bdgt_characters` (
`id` smallint(11) NOT NULL,
  `nickname` varchar(64) NOT NULL,
  `char_img_id` smallint(11) NOT NULL,
  `head_preset_id` smallint(2) NOT NULL,
  `torso_preset_id` smallint(2) NOT NULL,
  `legs_preset_id` smallint(2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bdgt_characters`
--

INSERT INTO `bdgt_characters` (`id`, `nickname`, `char_img_id`, `head_preset_id`, `torso_preset_id`, `legs_preset_id`) VALUES
(1, 'Ward de Bever', 2, 1, 2, 3),
(2, 'Nick', 22, 0, 0, 0),
(3, 'Miske', 80, 0, 0, 0),
(4, 'Thorr''s Invader', 26, 0, 0, 0),
(5, 'Nickname', 28, 0, 0, 0),
(6, 'Kitteh', 79, 0, 0, 0),
(7, 'cat stalin', 73, 0, 0, 0),
(8, 'Bqdger badger', 74, 0, 0, 0),
(9, 'Pieterke', 75, 0, 0, 0),
(10, 'Pi&ntilde;on ', 76, 0, 0, 0),
(11, 'derperderp', 77, 0, 0, 0),
(12, 'mattie', 78, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bdgt_images`
--

CREATE TABLE IF NOT EXISTS `bdgt_images` (
`id` smallint(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `width` smallint(5) NOT NULL,
  `height` smallint(5) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bdgt_images`
--

INSERT INTO `bdgt_images` (`id`, `filename`, `width`, `height`) VALUES
(2, 'testfile.png', 800, 600),
(4, 'C2AF6154-A30C-41EB-8758-79F678142FEA.png', 0, 0),
(5, 'FE531DE9-607A-4EF9-B6EF-67D51B1B2D77.png', 0, 0),
(6, '2652DF5F-CDB3-4D28-B12A-173A3D0FD03D.png', 0, 0),
(7, '1EC05BD4-CF95-4D97-BF7A-5C7A47254E98.png', 0, 0),
(8, 'BB5F6422-635C-4929-A2E5-E7C6032413D8.png', 0, 0),
(9, '8BCF8F80-2DC2-49BF-A94B-1BA168C20CE9.png', 0, 0),
(10, 'AEC69AC8-1615-40DB-90E9-64025921A159.png', 0, 0),
(11, '850F6A2D-2422-4B5D-99E2-3AF355B31677.png', 0, 0),
(12, '165B016E-AA0A-45F6-AC88-8DE27E858CBD.png', 0, 0),
(13, 'A9849F49-3D5F-464E-954A-E4FEAEDD600A.png', 0, 0),
(14, 'BA52A53B-2CDC-4CD6-88B1-1C3FEA0EC51A.png', 0, 0),
(15, '2F68ADCB-13F1-47E6-BD65-BC652B67CC27.png', 0, 0),
(16, '76871F77-DA0F-4FF2-AEF4-648A4F0F346E.png', 0, 0),
(17, 'D9AC4885-B1E1-425C-B545-02E9C35303F7.png', 0, 0),
(18, '9600B1D5-F0A2-4461-8B47-FA68C52415DB.png', 0, 0),
(19, 'C1B572DF-FEEE-430A-8862-086C2ED334C6.png', 0, 0),
(20, '162BA055-1436-412E-829E-7B8143FB8BC4.png', 0, 0),
(21, 'F2CDA00C-BF28-486A-8CB9-02A3432E9DDD.png', 0, 0),
(22, '47C82EEE-C878-42EF-BBC4-1C67CB4BF51E.png', 0, 0),
(23, '5E5EF094-BDEC-4E0F-8FB7-446133DD50A5.png', 0, 0),
(24, '5D63ED9B-EEFD-4527-934D-E12E47191854.png', 0, 0),
(25, '56D61027-BB96-4271-B125-2D8F536E3FF9.png', 0, 0),
(26, 'F92FAB19-7398-4A0B-9E6A-8CA4878ADD6A.png', 0, 0),
(27, '5C93202C-9A36-492C-A66E-E27B18B5E422.png', 0, 0),
(28, '51578A04-F3D7-4C0C-B499-DB02F72DD7BD.png', 0, 0),
(29, 'CCDEBFCD-2D49-4CE6-9719-C7A0576B0D74.png', 0, 0),
(30, '4C1F7FD2-0B16-44FE-A9DB-4E7A59F26D64.png', 0, 0),
(31, '86095581-505A-4558-816A-855A6B04296E.png', 0, 0),
(32, '55AE3F49-34FF-4229-A609-D308CD078A9F.png', 0, 0),
(33, '8E691FEC-2EBE-412E-86C0-40DE8C7F9D2A.png', 0, 0),
(34, 'C9BADBD5-1766-4358-97DF-5229ECB86AF0.png', 0, 0),
(35, 'DA26942D-65B2-456E-8D0D-791F257D0D47.png', 0, 0),
(36, 'AB3BF20B-A93F-40F3-9647-EF4BFDD5C9EA.png', 0, 0),
(37, 'B2AD954B-FD69-4659-97C7-3654EC1404B2.png', 0, 0),
(38, '72861FFD-66F0-4484-A649-946A5EA50ED5.png', 0, 0),
(39, '1FEA3AE3-2EE9-431B-AAC3-5BE367273F7F.png', 0, 0),
(40, '4AD344BB-F741-486D-A9E5-5A479C2084D7.png', 0, 0),
(41, '15218A13-5E7A-4400-8BA6-C466F268A374.png', 0, 0),
(42, '8A64E190-46ED-4AF1-A020-AC53B6DEF118.png', 0, 0),
(43, '478E51C8-0AB4-4E06-82C6-7D31B471755C.png', 0, 0),
(44, '6083571D-B7AE-4338-8E20-5E6B21717BCB.png', 0, 0),
(45, 'D5126432-CA80-4124-8315-F6C2AD3F54AC.png', 0, 0),
(46, '30928205-9C4A-43E6-9FE1-BC62FD3473E3.png', 0, 0),
(47, 'A831DC8C-45D3-45F7-A6C9-E3066DD6CDDB.png', 0, 0),
(48, 'A7FE1355-79D0-454F-9379-805EC3C56EE3.png', 0, 0),
(49, '5B815C0D-7FDC-45DB-B710-0A48E31869FD.png', 0, 0),
(50, '341D064F-789C-400E-AF07-6E11D47B0927.png', 0, 0),
(51, '6E6FDE32-3F0C-41D1-A5CA-2DE6FA81598D.png', 0, 0),
(52, 'BA0033D1-34B0-49C0-A611-9F6EF080436F.png', 0, 0),
(53, '6E3C61F3-2EFD-44A6-982A-DC109F03D335.png', 0, 0),
(54, '213473E4-E98A-4030-948F-F603C477A811.png', 0, 0),
(55, 'F05A0DAA-FFF9-4D05-89D1-9AB2A71626DD.png', 0, 0),
(56, 'B9851859-AD23-4E42-9D70-22A9F45DCFD2.png', 0, 0),
(57, 'F55E75D3-81A8-44D0-9E03-A8C83B3326B6.png', 0, 0),
(58, '9BBF09B8-E96C-4035-9232-9C08AB8A06F8.png', 0, 0),
(59, '83FC5F24-B85A-454A-94D8-89B454188B76.png', 0, 0),
(60, '44A2B61C-0109-4DBB-8201-CF051EF14367.png', 0, 0),
(61, 'E853A1B4-0370-47D4-8A57-99BF15938131.png', 0, 0),
(62, '0EB05FA2-E82B-41CF-B39B-6018CF5A693F.png', 0, 0),
(63, '999CE864-6A3B-4C49-9B6C-2C4ABA509165.png', 0, 0),
(64, '3FCDBBDF-75AF-4522-A897-21941A225628.png', 0, 0),
(65, '476D9A4D-B71C-4458-A652-218791CC01F3.png', 0, 0),
(66, 'F6D47395-14B4-4B37-ACE1-49912B49EF7D.png', 0, 0),
(67, '9751BE59-BD58-4F18-BE32-911508AB175A.png', 0, 0),
(68, 'B669EB5E-6319-487A-9053-8573B76F6080.png', 0, 0),
(69, 'B04FE0E4-4003-4C5F-B32C-BF4D29C4C4FE.png', 0, 0),
(70, '8C8D76DE-E043-45B1-9BF0-DBD0125DA9A9.png', 0, 0),
(71, 'C1AA96AE-C8A9-4F06-8FAA-1869CD7385DF.png', 0, 0),
(72, 'A84C38B0-0926-4E1F-B6B5-2D7D7480648A.png', 0, 0),
(73, 'E2DF3174-A11C-4D22-9797-DB33D22B7856.png', 0, 0),
(74, 'A7945418-C6F1-4A60-B330-6D035372FC77.png', 0, 0),
(75, '5257C459-1F1C-4B39-AD2A-88655AB7B4C7.png', 0, 0),
(76, '4E39BB67-FC0A-4E40-A88C-6AFFE470A1EF.png', 0, 0),
(77, '8BA18E79-1D5E-43B0-A503-38CC30090E2A.png', 0, 0),
(78, '2DDA624D-C3D3-4D13-A7A5-C817FD8A7A68.png', 0, 0),
(79, '6AC460AA-8D4D-4F07-B13B-5E90145B5225.png', 0, 0),
(80, 'E39E87E8-E8FF-40D1-AA4F-1B5C722A1667.png', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bdgt_presets`
--

CREATE TABLE IF NOT EXISTS `bdgt_presets` (
`id` smallint(11) NOT NULL,
  `type` varchar(24) NOT NULL,
  `filename` varchar(64) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bdgt_presets`
--

INSERT INTO `bdgt_presets` (`id`, `type`, `filename`) VALUES
(4, 'head', 'ThorrDansenDansen.png'),
(5, 'head', 'stalin.png'),
(6, 'head', 'derpman.png'),
(7, 'upper_body', 'nose_body.png'),
(8, 'head', 'KonijntjeHoofd.png'),
(10, 'head', 'YeOldeDerpHead.png'),
(11, 'head', 'ComicGrillHead.png'),
(12, 'head', 'ComicGuyHead.png'),
(13, 'lower_body', 'GorillaLegs.png'),
(14, 'lower_body', 'CatsLegs.png'),
(15, 'lower_body', 'PaintingLegs.png'),
(16, 'head', 'BeertjeHoofd.png'),
(17, 'upper_body', 'BeertjeTorso.png'),
(18, 'head', 'PutinWoman.png'),
(19, 'lower_body', 'PiggyRider.png'),
(20, 'upper_body', 'BeachBody.png'),
(21, 'head', 'DogTeethHead.png'),
(22, 'head', 'HeeeeeresKitty.png'),
(23, 'head', 'IlluminatiPyramid.png'),
(24, 'head', 'JesusHead.png'),
(25, 'head', 'ObamaDatAss.png'),
(26, 'lower_body', 'PurpleLongBoots.png'),
(27, 'head', 'PutinWinkHead.png'),
(28, 'head', 'UWotMate.png'),
(29, 'head', 'WillmaSmith.png'),
(30, 'upper_body', 'PillowHug.png'),
(31, 'upper_body', 'LitterallyATaco.png'),
(32, 'head', 'BatCat.png'),
(33, 'upper_body', 'CarrotCostume.png'),
(34, 'lower_body', 'ButtDashian.png'),
(35, 'upper_body', 'PizzaSlice.png'),
(36, 'upper_body', 'Borat.png'),
(37, 'upper_body', 'IDontEven.png'),
(38, 'head', 'JapaneseWarrior.png'),
(39, 'lower_body', 'KimCentaurian.png'),
(40, 'upper_body', 'BeachBodyBikini.png'),
(41, 'upper_body', 'CatBody.png'),
(42, 'lower_body', 'CatLowerBody.png'),
(43, 'lower_body', 'BodyBuilderBikiniLegs.png');

-- --------------------------------------------------------

--
-- Table structure for table `bdgt_uitlaat`
--

CREATE TABLE IF NOT EXISTS `bdgt_uitlaat` (
`id` smallint(11) NOT NULL,
  `character_id` smallint(11) NOT NULL,
  `title` varchar(24) NOT NULL,
  `message` varchar(380) NOT NULL,
  `latitude` float(10,6) NOT NULL,
  `longitude` float(10,6) NOT NULL,
  `time_posted` datetime NOT NULL,
  `score` smallint(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bdgt_uitlaat`
--

INSERT INTO `bdgt_uitlaat` (`id`, `character_id`, `title`, `message`, `latitude`, `longitude`, `time_posted`, `score`) VALUES
(1, 1, 'Regi', 'Zet die ploat af!', 50.960773, 5.353933, '2015-05-31 00:35:24', 0),
(2, 1, 'Pukkelpop 2015', 'Dansen Dansen', 50.960407, 5.354287, '2015-06-06 19:09:06', 0),
(3, 1, 'Pukkelpop 2015', 'Dansen Dansen', 50.960407, 5.354287, '2015-06-06 19:11:44', 0),
(4, 1, 'Pukkelpop 2015', 'Keynotes keynotes', 50.960407, 5.354287, '2015-06-08 17:18:37', 0),
(5, 0, 'Pukkelpop 2015', 'I am the night.', 50.960407, 5.354287, '2015-06-10 21:27:52', 0),
(6, 0, 'Pukkelpop 2015', 'Dansen ', 50.960407, 5.354287, '2015-06-11 00:40:41', 0),
(7, 0, 'Pukkelpop 2015', 'Dansen Dansen Aanpassen werkt D-:', 50.960407, 5.354287, '2015-06-12 23:42:28', 0),
(8, 0, 'Pukkelpop 2015', 'Ik ben aangepast. Dansen dansen', 50.960407, 5.354287, '2015-06-12 23:52:54', 0),
(9, 0, 'Pukkelpop 2015', 'Stiekem ben ik toch Beertje', 50.960407, 5.354287, '2015-06-12 23:55:25', 0),
(10, 0, 'Pukkelpop 2015', 'Zet die ploat af!', 50.960407, 5.354287, '2015-06-13 10:38:32', 0),
(11, 0, 'Pukkelpop 2015', 'testen testen', 50.960407, 5.354287, '2015-06-13 11:02:25', 0),
(12, 0, 'Pukkelpop 2015', 'Thorr''s invader is cool', 50.960407, 5.354287, '2015-06-13 15:34:09', 0),
(13, 6, 'Pukkelpop 2015', 'character id test', 50.960407, 5.354287, '2015-06-13 15:48:49', 0),
(14, 6, 'Pukkelpop 2015', 'Character ID test', 50.960407, 5.354287, '2015-06-13 15:53:17', 0),
(15, 6, 'Pukkelpop 2015', 'Derp dansen', 50.960407, 5.354287, '2015-06-13 17:08:35', 0),
(16, 6, 'Pukkelpop 2015', 'Testen testen!', 50.960407, 5.354287, '2015-06-13 20:28:02', 0),
(17, 6, 'Pukkelpop 2015', 'testen testen', 50.960407, 5.354287, '2015-06-14 00:40:26', 0),
(18, 4, 'Pukkelpop 2015', 'Testje', 50.960407, 5.354287, '2015-06-14 02:49:04', 0),
(19, 6, 'Pukkelpop 2015', 'Nog een kaartje!', 50.960407, 5.354287, '2015-06-14 03:09:07', 0),
(20, 6, 'Pukkelpop 2015', 'Major. 5u ''s contends ... Tijd om te gaan slapen!', 50.960407, 5.354287, '2015-06-14 05:12:10', 0),
(21, 3, 'Pukkelpop 2015', 'Bluuuurggg', 50.960407, 5.354287, '2015-06-14 10:11:55', 0),
(22, 6, 'Pukkelpop 2015', 'Pukkelpop stinkt!', 50.960407, 5.354287, '2015-06-14 12:47:13', 0),
(23, 6, 'Pukkelpop 2015', 'Wow, such festival. Much app ', 50.960407, 5.354287, '2015-06-14 12:56:10', 0),
(24, 6, 'Pukkelpop 2015', 'testje', 50.960407, 5.354287, '2015-06-14 13:47:07', 0),
(25, 6, 'Pukkelpop 2015', 'Nog een testje', 50.960407, 5.354287, '2015-06-14 14:12:14', 0),
(26, 6, 'Pukkelpop 2015', 'test 2', 50.960407, 5.354287, '2015-06-14 14:16:31', 0),
(27, 6, 'Pukkelpop 2015', 'Test 3', 50.960407, 5.354287, '2015-06-14 14:16:42', 0),
(28, 6, 'Pukkelpop 2015', 'test 4', 50.960407, 5.354287, '2015-06-14 14:34:14', 0),
(29, 6, 'Pukkelpop 2015', 'Newtest', 50.960407, 5.354287, '2015-06-14 14:40:26', 0),
(30, 6, 'Pukkelpop 2015', 'test 5', 50.960407, 5.354287, '2015-06-14 14:53:34', 0),
(31, 6, 'Pukkelpop 2015', 'le test', 50.960407, 5.354287, '2015-06-14 14:55:22', 0),
(32, 6, 'Pukkelpop 2015', 'djdfkj;lsdkj;jf;s', 50.960407, 5.354287, '2015-06-14 15:16:33', 0),
(33, 6, 'Pukkelpop 2015', 'hopelijk laatste test', 50.960407, 5.354287, '2015-06-14 15:21:10', 0),
(34, 3, 'Pukkelpop 2015', 'Je moeder, reggie, je moeder', 50.960407, 5.354287, '2015-06-14 15:49:25', 0),
(35, 3, 'Pukkelpop 2015', 'Test met mol', 50.960407, 5.354287, '2015-06-14 21:13:56', 0),
(36, 9, 'Pukkelpop 2015', 'Bqdges gqqn dynamic', 50.960407, 5.354287, '2015-06-15 10:45:58', 0),
(37, 11, 'Pukkelpop 2015', 'derprderp', 50.960407, 5.354287, '2015-06-15 10:57:13', 0),
(38, 12, 'Pukkelpop 2015', 'jo soi mattie', 50.960407, 5.354287, '2015-06-15 11:12:21', 0),
(39, 3, 'Pukkelpop 2015', 'Miske doet een post', 50.960407, 5.354287, '2015-06-15 12:16:52', 0),
(40, 6, 'Pukkelpop 2015', 'I can haz badge?', 50.960407, 5.354287, '2015-06-15 14:52:06', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bdgt_admins`
--
ALTER TABLE `bdgt_admins`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bdgt_characters`
--
ALTER TABLE `bdgt_characters`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bdgt_images`
--
ALTER TABLE `bdgt_images`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bdgt_presets`
--
ALTER TABLE `bdgt_presets`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bdgt_uitlaat`
--
ALTER TABLE `bdgt_uitlaat`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bdgt_admins`
--
ALTER TABLE `bdgt_admins`
MODIFY `id` smallint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `bdgt_characters`
--
ALTER TABLE `bdgt_characters`
MODIFY `id` smallint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `bdgt_images`
--
ALTER TABLE `bdgt_images`
MODIFY `id` smallint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT for table `bdgt_presets`
--
ALTER TABLE `bdgt_presets`
MODIFY `id` smallint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `bdgt_uitlaat`
--
ALTER TABLE `bdgt_uitlaat`
MODIFY `id` smallint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
