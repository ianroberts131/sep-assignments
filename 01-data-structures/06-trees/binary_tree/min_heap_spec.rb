include RSpec

require_relative 'min_heap'

RSpec.describe MinHeap, type: Class do
  let (:root)                 { Node.new("The Big Lebowski", 81) }
  
  let (:heap)                 { MinHeap.new(root) }
  let (:memento)              { Node.new("Memento", 92) }
  let (:primer)               { Node.new("Primer", 71) }
  let (:looper)               { Node.new("Looper", 93) }
  let (:cloud_atlas)          { Node.new("Cloud Atlas", 66) }
  let (:american_history_x)   { Node.new("American History X", 83) }
  let (:fight_club)           { Node.new("Fight Club", 79) }
  let (:shawshank)            { Node.new("The Shawshank Redemption", 91) }
  let (:pulp_fiction)         { Node.new("Pulp Fiction", 94) }
  let (:forrest_gump)         { Node.new("Forrest Gump", 72) }
  let (:ususal_suspects)      { Node.new("The Usual Suspects", 88) }
  let (:sandlot)              { Node.new("The Sandlot", 58) }
    
  describe "#insert(data)" do
    it "properly inserts a new node to the heap" do
      heap.insert(root, memento)
      expect(heap.items[1].title).to eq "Memento"
    end
      
    it "properly orders the min heap so parent nodes are smallest" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      expect(heap.items[0].title).to eq "Primer"
    end
      
    it "can handle replacing the first node" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      heap.insert(root, cloud_atlas)
      heap.insert(root, american_history_x)
      heap.insert(root, fight_club)
      heap.insert(root, shawshank)
      heap.insert(root, pulp_fiction)
      heap.insert(root, forrest_gump)
      heap.insert(root, ususal_suspects)
      heap.insert(root, sandlot)
          
      expect(heap.items[0].title).to eq "The Sandlot"
    end
  end
    
  describe "#find(data)" do
    it "handles nil gracefully" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      expect(heap.find(root, nil)).to be_nil
    end
    
    it "properly finds the largest rating" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      heap.insert(root, cloud_atlas)
      heap.insert(root, american_history_x)
      heap.insert(root, fight_club)
      heap.insert(root, shawshank)
      heap.insert(root, pulp_fiction)
      heap.insert(root, forrest_gump)
      heap.insert(root, ususal_suspects)
      heap.insert(root, sandlot)
          
      expect(heap.find(root, "Pulp Fiction").title).to eq "Pulp Fiction"
    end
    
    it "properly finds the smallest rating" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      heap.insert(root, cloud_atlas)
      heap.insert(root, american_history_x)
      heap.insert(root, fight_club)
      heap.insert(root, shawshank)
      heap.insert(root, pulp_fiction)
      heap.insert(root, forrest_gump)
      heap.insert(root, ususal_suspects)
      heap.insert(root, sandlot)
          
      expect(heap.find(root, "The Sandlot").title).to eq "The Sandlot"
    end
  end
  
  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(heap.delete(root, nil)).to be_nil
    end
    
    it "properly deletes the first item" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      heap.delete(root, primer.title)
      expect(heap.find(root, primer.title)).to be_nil
    end
    
    it "properly deletes the last item" do
      heap.insert(root, memento)
      heap.insert(root, primer)
      heap.insert(root, cloud_atlas)
      heap.insert(root, american_history_x)
      heap.insert(root, fight_club)
      heap.insert(root, shawshank)
      heap.insert(root, pulp_fiction)
      heap.insert(root, forrest_gump)
      heap.insert(root, ususal_suspects)
      heap.insert(root, sandlot)
      
      heap.delete(root, american_history_x.title)
      expect(heap.find(root, american_history_x.title)).to be_nil
    end
  end
  
  describe "#printf" do
   specify {
     expected_output = "The Sandlot: 58\nPrimer: 71\nCloud Atlas: 66\nThe Shawshank Redemption: 91\nForrest Gump: 72\nFight Club: 79\nThe Big Lebowski: 81\nLooper: 93\nPulp Fiction: 94\nMemento: 92\nThe Usual Suspects: 88\nAmerican History X: 83\n"
      heap.insert(root, memento)
      heap.insert(root, primer)
      heap.insert(root, looper)
      heap.insert(root, cloud_atlas)
      heap.insert(root, american_history_x)
      heap.insert(root, fight_club)
      heap.insert(root, shawshank)
      heap.insert(root, pulp_fiction)
      heap.insert(root, forrest_gump)
      heap.insert(root, ususal_suspects)
      heap.insert(root, sandlot)
      expect { heap.printf }.to output(expected_output).to_stdout
   }
 end
  
end